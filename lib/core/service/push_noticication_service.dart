import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/receipt/presentation/receipt.dart';

class PushNotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // initalize local notifications
  static Future localNotificationInit() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onForegroundNotificationTap,
        onDidReceiveBackgroundNotificationResponse:
            _onBackgroundNotificationTap);
  }

  static Future<void> setUpPushNotification() async {
    localNotificationInit();
    //Todo for handling in foreground state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Got a message in foreground");
      String payloadData = jsonEncode(message.data);
      if (message.notification != null) {
        showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      }
    });

    //Todo for handling in background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Got a message in onMessageOpenedApp");
      // String payloadData = jsonEncode(message.data);
      // if (message.notification != null) {
      //   PushNotificationService.showNotification(
      //       title: message.notification!.title!,
      //       body: message.notification!.body!,
      //       payload: payloadData);
      // }
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //Todo for handling in terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Got a message in terminated state");
      // String payloadData = jsonEncode(message?.data);
      // if (message != null && message.notification != null) {
      //   PushNotificationService.showNotification(
      //       title: message.notification!.title!,
      //       body: message.notification!.body!,
      //       payload: payloadData);
      // }
    });
  }

  // request notification permission
  static Future<bool> requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    return token ?? "";
  }

  // on tap local notification in foreground
  static void _onForegroundNotificationTap(
      NotificationResponse notificationResponse) {
    // Parse the JSON string
    Map<String, dynamic> parsedJson =
        jsonDecode(notificationResponse.payload ?? "");

    // Extract the order_id
    String orderId = parsedJson['order_id'];
    NavigationUtil.pushNamed(ReceiptPage.route, arguments: orderId);
  }

  // on tap local notification in background
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTap(
      NotificationResponse notificationResponse) {
    // Parse the JSON string
    Map<String, dynamic> parsedJson =
        jsonDecode(notificationResponse.payload ?? "");

    // Extract the order_id
    String orderId = parsedJson['order_id'];
    NavigationUtil.pushNamed(ReceiptPage.route, arguments: orderId);
  }

  // show a simple notification
  static Future showNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('shopfee', 'shopfee',
            channelDescription: 'This is shopfee channel description',
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            color: Colors.white,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Got a message in onBackgroundMessage");
  // String payloadData = jsonEncode(message.data);
  // if (message.notification != null) {
  //   PushNotificationService.showNotification(
  //       title: message.notification!.title!,
  //       body: message.notification!.body!,
  //       payload: payloadData);
  // }
}
