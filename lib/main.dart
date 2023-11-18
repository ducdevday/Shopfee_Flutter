import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/cubit/my_bottom_navigation_bar_cubit.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/theme.dart';
import 'package:shopfee/app/features/account/bloc/account_bloc.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/home/bloc/home_bloc.dart';
import 'package:shopfee/app/utils/navigation_util.dart';
import 'package:shopfee/app/utils/simple_bloc_observer.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/category/category_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';
import 'package:shopfee/data/repositories/place/place_repository.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';
import 'package:shopfee/data/repositories/transaction/transaction_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

import 'app/utils/global_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  Bloc.observer = SimpleBlocObserver();
  _initData();
  runApp(const MyApp());
}

Future<void> _initData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  GlobalData.ins.isFirstTime = prefs.getBool('isFirstTime') ?? true;
  GlobalData.ins.userId = prefs.getString('userId');
  GlobalData.ins.accessToken = prefs.getString('accessToken');
  GlobalData.ins.refreshToken = prefs.getString('refreshToken');
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    initInfoNotify();
    setupMessageNotify();
  }

  void initInfoNotify() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/launcher_icon');
    var initialSettings = InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      try {
        if (notificationResponse.payload != null &&
            notificationResponse.payload!.isNotEmpty) {
          NavigationUtil.pushNamed(
              route:AppRouter.receiptRoute, args: notificationResponse.payload);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  void setupMessageNotify() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('shopfee', 'shopfee',
              channelDescription: ' This is shopfee channel description',
              importance: Importance.max,
              priority: Priority.high,
              playSound: true,
              color: Colors.white);
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data["destinationId"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    // initializeDateFormatting('vi');
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => CategoryRepository()),
        RepositoryProvider(create: (_) => ProductRepository()),
        RepositoryProvider(create: (_) => AddressRepository()),
        RepositoryProvider(create: (_) => PlaceRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
        RepositoryProvider(create: (_) => TransactionRepository()),
        RepositoryProvider(create: (_) => LocalRepository()),
        RepositoryProvider(create: (_) => FirebaseRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => CartBloc(
                  orderRepository: context.read<OrderRepository>(),
                  addressRepository: context.read<AddressRepository>(),
                  firebaseRepository: context.read<FirebaseRepository>())
                ..add(LoadCart())),
          BlocProvider(
              create: (context) => HomeBloc(
                  categoryRepository: context.read<CategoryRepository>(),
                  productRepository: context.read<ProductRepository>())
                ..add(LoadHome())),
          BlocProvider(
              create: (context) =>
                  HistoryBloc(orderRepository: context.read<OrderRepository>())
                    ..add(const LoadHistory(
                        historyStatus: HistoryStatus.Processing))),
          BlocProvider(
              create: (context) => AccountBloc(
                  userRepository: context.read<UserRepository>(),
                  localRepository: context.read<LocalRepository>(),
                  firebaseRepository: context.read<FirebaseRepository>())
                ..add(LoadAccount())),
          BlocProvider(
              create: (context) => MyBottomNavigationBarCubit()..selectPage(0))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) {
            return AppRouter.onGenerateRoute(settings);
          },
          initialRoute: AppRouter.splashRoute,
          // home: ReceiptScreen(orderId: "65431e85f4b1650e5f20af1a"),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
