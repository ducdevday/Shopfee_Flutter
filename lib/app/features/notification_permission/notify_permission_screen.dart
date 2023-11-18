import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';

class NotifyPermissionScreen extends StatefulWidget {
  const NotifyPermissionScreen({Key? key}) : super(key: key);

  @override
  State<NotifyPermissionScreen> createState() => _NotifyPermissionScreenState();
}

class _NotifyPermissionScreenState extends State<NotifyPermissionScreen> {
  // late String fcmToken;

  @override
  void initState() {
    super.initState();
    // getToken();
  }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) => {
  //         setState(() {
  //           fcmToken = token!;
  //         }),
  //         print("FCM Token:" + token!)
  //       });
  // }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("User granted permission");
      await setFistTime();
      Navigator.pushNamedAndRemoveUntil(context, AppRouter.welcomeRoute, (route) => false);
    } else {
      print("User denied permission");
    }
  }

  Future<void> setFistTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstTime", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_notification.svg",
                  width: 250,
                  height: 250,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Notify",
                  style: AppStyle.largeTitleStyleDark,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Text(
                    "Please turn on notifications on the app to receive our notifications",
                    style: AppStyle.mediumTextStyleDark,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(AppDimen.screenPadding),
              child: ElevatedButton(
                onPressed: () {
                  requestPermission();
                },
                child: const Text("Turn on"),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    disabledBackgroundColor: const Color(0xffCACACA),
                    disabledForegroundColor: AppColor.lightColor,
                    textStyle: AppStyle.mediumTextStyleDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
