import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/config/routes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 3000), () {
      if (GlobalData.ins.isFirstTime) {
        Navigator.pushNamedAndRemoveUntil(context, AppRouter.onBoardingRoute, (route) => false);
      } else if (GlobalData.ins.userId != null) {
        Navigator.pushNamedAndRemoveUntil(context, AppRouter.homeRoute, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, AppRouter.welcomeRoute, (route) => false);
      }
    });
    return Scaffold(
      backgroundColor: Colors.white, // Change to your desired background color
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/img_logo_one.png', // Path to your image
              width: 274, // Adjust the image size as needed
              height: 202,
            ),
          ),
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 400),
                  child:
                      CircularProgressIndicator())), // Circular Progress Indicator
        ],
      ),
    );
  }
}
