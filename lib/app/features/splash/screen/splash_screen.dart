import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 3000), () {
      Navigator.pushReplacementNamed(context, "/onboarding");
    });
    return Scaffold(
      backgroundColor: Colors.white, // Change to your desired background color
      body: Stack(
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/onboarding_one.svg', // Path to your image
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
