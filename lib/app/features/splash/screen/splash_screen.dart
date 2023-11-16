import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopfee/app/common/data/global_data.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 3000), () {
      if (GlobalData.ins.isFirstTime) {
        Navigator.pushReplacementNamed(context, "/onboarding");
      } else if (GlobalData.ins.userId != null) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/welcome");
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
