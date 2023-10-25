import 'package:flutter/material.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/my_bottom_navigationbar.dart';
import 'package:shopfee/app/common/widgets/my_page_route.dart';
import 'package:shopfee/app/features/account/screen/account_screen.dart';
import 'package:shopfee/app/features/account_change_password/screen/account_change_password_screen.dart';
import 'package:shopfee/app/features/cart/screen/cart_screen.dart';
import 'package:shopfee/app/features/change_password/screen/change_password_screen.dart';
import 'package:shopfee/app/features/forgot_password/screen/forgot_password_screen.dart';
import 'package:shopfee/app/features/geolocation/screen/geolocation_screen.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/home/screen/home_screen.dart';
import 'package:shopfee/app/features/login/screen/login_screen.dart';
import 'package:shopfee/app/features/new_address/screens/new_address_screen.dart';
import 'package:shopfee/app/features/onboarding/screen/onboarding_screen.dart';
import 'package:shopfee/app/features/otp/screen/otp_screen.dart';
import 'package:shopfee/app/features/personal_information/screen/personal_information_screen.dart';
import 'package:shopfee/app/features/receipt/screen/receipt_screen.dart';
import 'package:shopfee/app/features/register/screen/register_screen.dart';
import 'package:shopfee/app/features/review/screen/review_screen.dart';
import 'package:shopfee/app/features/saved_address/screens/saved_address_screen.dart';
import 'package:shopfee/app/features/search/screen/search_screen.dart';
import 'package:shopfee/app/features/splash/screen/splash_screen.dart';
import 'package:shopfee/app/features/tracking/screen/tracking_screen.dart';
import 'package:shopfee/app/features/vnpay/screen/VNPayScreen.dart';
import 'package:shopfee/app/features/voucher/screen/voucher_screen.dart';
import 'package:shopfee/app/features/welcome/screen/welcome_screen.dart';

class AppRouter {
  static final myBottomNavigationBar = MyBottomNavigationBar();

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/splash":
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case "/onboarding":
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case "/register":
        return MaterialPageRoute(
            builder: (context) =>
                RegisterScreen(email: settings.arguments as String));
      case "/welcome":
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case "/login":
        return MaterialPageRoute(
            builder: (context) => LoginScreen(
                email: settings.arguments == null
                    ? null
                    : settings.arguments as String));
      case "/otp":
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (context) => OtpScreen(
                routeName: args["routeName"]!, email: args["email"]!));
      case "/forgot_password":
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      case "/change_password":
        return MaterialPageRoute(
            builder: (context) =>
                ChangePasswordScreen(email: settings.arguments as String));
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

      case "/change_password_in_account":
        return MaterialPageRoute(
            builder: (context) => GuardRoute(AccountChangePasswordScreen()));

      case "/voucher":
        return MaterialPageRoute(builder: (context) => VoucherScreen());
      case "/receipt":
        return MaterialPageRoute(
            builder: (context) => ReceiptScreen(
                  orderId: settings.arguments as String,
                ));
      case "/tracking":
        return MaterialPageRoute(
            builder: (context) => TrackingScreen(
                  orderId: settings.arguments as String,
                ));
      case "/review":
        return MaterialPageRoute(
            builder: (context) => ReviewScreen(
                  orderId: settings.arguments as String,
                ));
      case "/personal_information":
        return MaterialPageRoute(
            builder: (context) => PersonalInformationScreen());
      case "/saved_address":
        final isFromCart =
            settings.arguments != null ? settings.arguments as bool : null;
        return MaterialPageRoute(
            builder: (context) => SavedAddressScreen(isFromCart: isFromCart));
      case "/new_address":
        final addressId =
            settings.arguments != null ? settings.arguments as String : null;
        return MaterialPageRoute(
            builder: (context) => NewAddressScreen(
                  addressId: addressId,
                ));
      case "/vnpay":
        final args = settings.arguments as Map<String, String?>;
        return MaterialPageRoute(
            builder: (context) => VNPayScreen(
                  paymentUrl: args["paymentUrl"]!,
                  orderId: args["orderId"]!,
                  transactionId: args["transactionId"]!,
                ));
      case "/geolocation":
        return MaterialPageRoute(builder: (context) => GeolocationScreen());

      case "/cart":
        return MaterialPageRoute(builder: (context) => GuardRoute(CartScreen()));
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

Widget GuardRoute(Widget widget) {
  if (GlobalData.ins.userId == null) {
    return WelcomeScreen(isInHome: true);
  } else {
    return widget;
  }
}
