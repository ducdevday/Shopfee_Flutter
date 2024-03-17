import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shopfee/core/common/widgets/my_page_route.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/change_password/presentation/change_password.dart';
import 'package:shopfee/features/choose_address/presentation/choose_address.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/forgot_password/presentation/forgot_password.dart';
import 'package:shopfee/features/google_map/presentation/page/google_map_page.dart';
import 'package:shopfee/features/history/presentation/history.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/new_address/presentation/new_address.dart';
import 'package:shopfee/features/new_password/presentation/new_password.dart';
import 'package:shopfee/features/notify_permission/presentation/notify_permission.dart';
import 'package:shopfee/features/onboarding/presentation/onboarding.dart';
import 'package:shopfee/features/otp/presentation/otp.dart';
import 'package:shopfee/features/personal_information/presentation/personal_information.dart';
import 'package:shopfee/features/product_by_category/presentation/product_by_category.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';
import 'package:shopfee/features/receipt/presentation/receipt.dart';
import 'package:shopfee/features/register/presentation/register.dart';
import 'package:shopfee/features/saved_address/presentation/saved_address.dart';
import 'package:shopfee/features/search/presentation/search.dart';
import 'package:shopfee/features/splash/presentation/splash.dart';
import 'package:shopfee/features/store/presentation/store.dart';
import 'package:shopfee/features/store_detail/presentation/store_detail.dart';
import 'package:shopfee/features/tracking/presentation/tracking.dart';
import 'package:shopfee/features/vnpay/presentation/vnpay.dart';

class AppRouter {
  static onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashPage.route:
        return UnanimatedPageRoute(builder: (context) => SplashPage());
      case OnBoardingPage.route:
        return UnanimatedPageRoute(builder: (context) => OnBoardingPage());
      case NotifyPermissionPage.route:
        return MaterialPageRoute(builder: (context) => NotifyPermissionPage());
      case RegisterPage.route:
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case LoginPage.route:
        return MaterialPageRoute(
            builder: (context) => LoginPage(
                  fromRoute: settings.arguments as String?,
                ));
      case OtpPage.route:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => OtpPage(
                  email: args["email"],
                  fromRoute: args["fromRoute"],
                  registerEntity: args["registerEntity"],
                ));
      case ForgotPasswordPage.route:
        return MaterialPageRoute(builder: (context) => ForgotPasswordPage());
      case ChangePasswordPage.route:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => ChangePasswordPage(
                  email: args["email"],
                  code: args["code"],
                ));
      case NewPasswordPage.route:
        return MaterialPageRoute(builder: (context) => const NewPasswordPage());
      case DefaultPage.route:
        return MaterialPageRoute(builder: (context) => DefaultPage());
      case ProductByCategoryPage.route:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => ProductByCategoryPage(
                categoryId: args["categoryId"],
                categoryName: args["categoryName"]));
      case SearchPage.route:
        return PageTransition(
            child: SearchPage(), type: PageTransitionType.topToBottom);
      case ProductDetailPage.route:
        return PageTransition(
            child: ProductDetailPage(productId: settings.arguments as String),
            type: PageTransitionType.bottomToTop);
      case CartPage.route:
        return MaterialPageRoute(builder: (context) => const CartPage());
      case SavedAddressPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                SavedAddressPage(fromRoute: settings.arguments as String));
      case NewAddressPage.route:
        return MaterialPageRoute(
            builder: (context) => NewAddressPage(
                  addressId: settings.arguments as String?,
                ));
      case ChooseAddressPage.route:
        return MaterialPageRoute(builder: (context) => ChooseAddressPage());
      case VnPayPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                VnPayPage(orderResult: settings.arguments as OrderResult));
      case ReceiptPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                ReceiptPage(orderId: settings.arguments as String));
      case TrackingPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                TrackingPage(orderId: settings.arguments as String));
      case HistoryPage.route:
        return PageTransition(
            child: HistoryPage(), type: PageTransitionType.rightToLeft);
      case GoogleMapPage.route:
        return MaterialPageRoute(
            builder: (context) => GoogleMapPage(
                  addressString: settings.arguments as String,
                ));
      case PersonalInformationPage.route:
        return MaterialPageRoute(
            builder: (context) => const PersonalInformationPage());
      case StoreDetailPage.route:
        return PageTransition(
            child: StoreDetailPage(
              branchId: settings.arguments as String,
            ),
            type: PageTransitionType.bottomToTop);
      case ImageFullScreen.route:
        return PageTransition(
            child: ImageFullScreen(
              imgPath: settings.arguments as String,
            ),
            type: PageTransitionType.fade);
      case StorePage.route:
        return MaterialPageRoute(
            builder: (context) =>
                StorePage(fromRoute: settings.arguments as String));
      case StoreSearchPage.route:
        return MaterialPageRoute(
            builder: (context) =>
                StoreSearchPage(getAll: settings.arguments as bool));
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

// Widget GuardRoute(Widget widget) {
//   if (GlobalData.ins.userId == null) {
//     return WelcomeScreen(isInHome: true);
//   } else {
//     return widget;
//   }
// }
