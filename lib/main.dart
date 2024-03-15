import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopfee/core/config/app_theme.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/global/global_data.dart';
import 'package:shopfee/core/router/app_router.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/global_keys.dart';
import 'package:shopfee/core/utils/simple_bloc_observer.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/order/presentation/order.dart';
import 'package:shopfee/features/splash/presentation/splash.dart';
import 'package:shopfee/features/user/presentation/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  await FlutterConfig.loadEnvVariables();
  await SharedService.init();
  await ServiceLocator().init();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  await initData();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
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
          // NavigationUtil.pushNamed(
          //     route:AppRouter.receiptRoute, args: notificationResponse.payload);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<UserBloc>()..add(UserLoadInformation())),
        BlocProvider(create: (context) => MyBottomNavBarCubit()..selectPage(HomePage.indexPage)),
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<HomeBloc>()..add(HomeLoadInformation())),
        BlocProvider(
            create: (context) => ServiceLocator.sl<OrderBloc>()
              ..add(OrderLoadInformation(page: 1, size: 8))),
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<CartBloc>()..add(CartLoadInformation()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) {
          return AppRouter.onGenerateRoute(settings);
        },
        initialRoute: SplashPage.route,
        // home: ReceiptPage(orderId: "65769f84b8b782778bc5c17a"),
        builder: EasyLoading.init(),
      ),
    );
  }
}

Future<void> initData() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  SharedService.setAppDocPath(appDocPath);

  await GlobalData.ins.createCustomIcon();
  if(GlobalData.ins.currentPosition != null) {
    await GlobalData.ins.getCurrentPosition();
  }
}
