
import 'package:flutter/material.dart';
import 'package:shopfee/app/features/home/screen/home_screen.dart';
import 'package:shopfee/app/features/onboarding/screen/onboarding_screen.dart';
import 'package:shopfee/app/features/otp/screen/otp_screen.dart';
import 'package:shopfee/app/features/register/screen/register_screen.dart';
import 'package:shopfee/app/features/splash/screen/splash_screen.dart';

class AppRouter {
  static onGenerateRoute(RouteSettings settings){
    switch(settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case "/onboarding":
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case "/register":
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case "/home":
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case "/otp":
        return MaterialPageRoute(builder: (context) => OtpScreen());
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Some thing went wrong"),
          ),
        ));
  }
}

