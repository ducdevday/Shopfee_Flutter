import 'package:flutter/material.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/common/widgets/my_page_route.dart';
import 'package:shopfee/app/features/account/screen/account_screen.dart';
import 'package:shopfee/app/features/cart/screen/cart_screen.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/home/screen/home_screen.dart';
import 'package:shopfee/app/features/login/screen/login_screen.dart';
import 'package:shopfee/app/features/onboarding/screen/onboarding_screen.dart';
import 'package:shopfee/app/features/otp/screen/otp_screen.dart';
import 'package:shopfee/app/features/receipt/screen/receipt_screen.dart';
import 'package:shopfee/app/features/register/screen/register_screen.dart';
import 'package:shopfee/app/features/review/screen/review_screen.dart';
import 'package:shopfee/app/features/search/screens/search_screen.dart';
import 'package:shopfee/app/features/splash/screen/splash_screen.dart';
import 'package:shopfee/app/features/tracking/screen/tracking_screen.dart';
import 'package:shopfee/app/features/voucher/screen/voucher_screen.dart';

class AppRouter {
  static final myBottomNavigationBar = MyBottomNavigationBar();

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case "/onboarding":
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case "/register":
        return MaterialPageRoute(builder: (context) => RegisterScreen());
      case "/login":
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case "/home":
        return UnanimatedPageRoute(
            builder: (context) => HomeScreen(myBottomNavigationBar));
      case "/history":
        return UnanimatedPageRoute(
            builder: (context) => HistoryScreen(myBottomNavigationBar));
      case "/account":
        return UnanimatedPageRoute(
            builder: (context) => AccountScreen(myBottomNavigationBar));
      case "/search":
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case "/otp":
        return MaterialPageRoute(builder: (context) => OtpScreen());
      case "/cart":
        return MaterialPageRoute(builder: (context) => CartScreen());
      case "/voucher":
        return MaterialPageRoute(builder: (context) => VoucherScreen());
      case "/receipt":
        return MaterialPageRoute(builder: (context) => ReceiptScreen());
      case "/tracking":
        return MaterialPageRoute(builder: (context) => TrackingScreen());
      case "/review":
        return MaterialPageRoute(builder: (context) => ReviewScreen());
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
