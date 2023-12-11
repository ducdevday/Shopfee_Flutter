import 'package:flutter/material.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/my_bottom_navigationbar.dart';
import 'package:shopfee/app/common/widgets/my_page_route.dart';
import 'package:shopfee/app/features/account/screen/account_screen.dart';
import 'package:shopfee/app/features/account_change_password/screen/account_change_password_screen.dart';
import 'package:shopfee/app/features/cart/screen/cart_screen.dart';
import 'package:shopfee/app/features/change_password/screen/change_password_screen.dart';
import 'package:shopfee/app/features/default/screen/default_screen.dart';
import 'package:shopfee/app/features/forgot_password/screen/forgot_password_screen.dart';
import 'package:shopfee/app/features/geolocation/screen/geolocation_screen.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/home/screen/home_screen.dart';
import 'package:shopfee/app/features/login/screen/login_screen.dart';
import 'package:shopfee/app/features/new_address/screens/new_address_screen.dart';
import 'package:shopfee/app/features/notification_permission/notify_permission_screen.dart';
import 'package:shopfee/app/features/onboarding/screen/onboarding_screen.dart';
import 'package:shopfee/app/features/otp/screen/otp_screen.dart';
import 'package:shopfee/app/features/personal_information/screen/personal_information_screen.dart';
import 'package:shopfee/app/features/product/screen/product_screen.dart';
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
  static const splashRoute = "/splash";
  static const onBoardingRoute = "/onboarding";
  static const notifyPermissionRoute = "/notify_permission";
  static const registerRoute = "/register";
  static const welcomeRoute = "/welcome";
  static const loginRoute = "/login";
  static const otpRoute = "/otp";
  static const forgotPasswordRoute = "/forgot_password";
  static const changePasswordRoute = "/change_password";
  static const homeRoute = "/home";

  // static const historyRoute = "/history";
  // static const accountRoute = "/account";
  static const searchRoute = "/search";
  static const productRoute = "/product";
  static const changePasswordInAccountRoute = "/change_password_in_account";
  static const voucherRoute = "/voucher";
  static const receiptRoute = "/receipt";
  static const trackingRoute = "/tracking";
  static const reviewRoute = "/review";
  static const personalInformationRoute = "/personal_information";
  static const savedAddressRoute = "/saved_address";
  static const newAddressRoute = "/new_address";
  static const vnpayRoute = "/vnpay";
  static const geolocationRoute = "/geolocation";
  static const cartRoute = "/cart";

  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case onBoardingRoute:
        return MaterialPageRoute(builder: (context) => OnBoardingScreen());
      case notifyPermissionRoute:
        return MaterialPageRoute(
            builder: (context) => NotifyPermissionScreen());
      case registerRoute:
        return MaterialPageRoute(
            builder: (context) =>
                RegisterScreen(email: settings.arguments as String));
      case welcomeRoute:
        final isInHome = settings.arguments != null ? settings.arguments as bool : null;
        return MaterialPageRoute(builder: (context) => WelcomeScreen(isInHome: isInHome));
      case loginRoute:
        return MaterialPageRoute(
            builder: (context) => LoginScreen(
                email: settings.arguments == null
                    ? null
                    : settings.arguments as String));
      case otpRoute:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (context) => OtpScreen(
                routeName: args["routeName"]!, email: args["email"]!));
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (context) => ForgotPasswordScreen());
      case changePasswordRoute:
        return MaterialPageRoute(
            builder: (context) =>
                ChangePasswordScreen(email: settings.arguments as String));
      case homeRoute:
        return MaterialPageRoute(builder: (context) => DefaultScreen());
      // case homeRoute:
      //   return UnanimatedPageRoute(
      //       builder: (context) => HomeScreen(myBottomNavigationBar));
      // case historyRoute:
      //   return UnanimatedPageRoute(
      //       builder: (context) => HistoryScreen(myBottomNavigationBar));
      // case accountRoute:
      //   return UnanimatedPageRoute(
      //       builder: (context) => AccountScreen(myBottomNavigationBar));
      case searchRoute:
        return MaterialPageRoute(builder: (context) => SearchScreen());
      case productRoute:
        return MaterialPageRoute(
            builder: (context) => ProductScreen(settings.arguments as String));
      case changePasswordInAccountRoute:
        return MaterialPageRoute(
            builder: (context) => GuardRoute(AccountChangePasswordScreen()));

      case voucherRoute:
        return MaterialPageRoute(builder: (context) => VoucherScreen());
      case receiptRoute:
        return MaterialPageRoute(
            builder: (context) => ReceiptScreen(
                  orderId: settings.arguments as String,
                ));
      case trackingRoute:
        return MaterialPageRoute(
            builder: (context) => TrackingScreen(
                  orderId: settings.arguments as String,
                ));
      case reviewRoute:
        return MaterialPageRoute(
            builder: (context) => ReviewScreen(
                  orderId: settings.arguments as String,
                ));
      case personalInformationRoute:
        return MaterialPageRoute(
            builder: (context) => PersonalInformationScreen());
      case savedAddressRoute:
        final isFromCart =
            settings.arguments != null ? settings.arguments as bool : null;
        return MaterialPageRoute(
            builder: (context) =>
                SavedAddressScreen(isFromCart: isFromCart));
      case newAddressRoute:
        final addressId =
            settings.arguments != null ? settings.arguments as String : null;
        return MaterialPageRoute(
            builder: (context) => GuardRoute(NewAddressScreen(
                  addressId: addressId,
                )));
      case vnpayRoute:
        final args = settings.arguments as Map<String, String?>;
        return MaterialPageRoute(
            builder: (context) => VNPayScreen(
                  paymentUrl: args["paymentUrl"]!,
                  orderId: args["orderId"]!,
                  transactionId: args["transactionId"]!,
                ));
      case geolocationRoute:
        return MaterialPageRoute(builder: (context) => GeolocationScreen());
      case cartRoute:
        return MaterialPageRoute(builder: (context) => CartScreen());
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
