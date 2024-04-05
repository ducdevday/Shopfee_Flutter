import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopfee/core/config/app_theme.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/router/app_router.dart';
import 'package:shopfee/core/utils/global_keys.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/order/presentation/order.dart';
import 'package:shopfee/features/preferential/presentation/preferential.dart';
import 'package:shopfee/features/splash/presentation/splash.dart';
import 'package:shopfee/features/user/presentation/user.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    // initInfoNotify();
    // setupMessageNotify();
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
              channelDescription: 'This is shopfee channel description',
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
        BlocProvider(
            create: (context) =>
                MyBottomNavBarCubit()..selectPage(HomePage.indexPage)),
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<HomeBloc>()..add(HomeLoadInformation())),
        BlocProvider(
            create: (context) => ServiceLocator.sl<OrderBloc>()
              ..add(const OrderLoadInformation(page: 1, size: 8))),
        BlocProvider(
            create: (context) => ServiceLocator.sl<PreferentialBloc>()
              ..add(const PreferentialLoadTopCoupon(quantityTop: 5))),
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
        // home: ReceiptPage(orderId: "OB000000001"),
        builder: EasyLoading.init(),
      ),
    );
  }
}
