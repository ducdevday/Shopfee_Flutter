import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shopfee/core/utils/navigation_util.dart';

class PushNotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // request notification permission
  static Future<void> requestPermission() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future<String> getFCMToken() async {
    final token = await _firebaseMessaging.getToken();
    return token ?? "";
  }

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
        onDidReceiveBackgroundNotificationResponse: _onBackgroundNotificationTap);
  }

  // on tap local notification in foreground
  static void _onForegroundNotificationTap(NotificationResponse notificationResponse) {
    NavigationUtil.pushNamed("/message", arguments: notificationResponse);
  }

  // on tap local notification in background
  @pragma('vm:entry-point')
  static void _onBackgroundNotificationTap(NotificationResponse notificationResponse) {
    NavigationUtil.pushNamed("/message", arguments: notificationResponse);
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
