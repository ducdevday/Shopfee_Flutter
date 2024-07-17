import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_theme.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/router/app_router.dart';
import 'package:shopfee/core/utils/global_keys.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/order/presentation/order.dart';
import 'package:shopfee/features/preferential/presentation/preferential.dart';
import 'package:shopfee/features/splash/presentation/splash.dart';
import 'package:shopfee/features/user/presentation/user.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<UserBloc>()..add(UserLoadInformation())),
        BlocProvider(
            create: (context) =>
                MyBottomNavBarCubit()..selectPage(HomePage.indexPage)),
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<HomeBloc>()..add(HomeLoadInformation())),
        BlocProvider(
            create: (context) => ServiceLocator.sl<OrderBloc>()
              ..add(const OrderLoadInformation(initPage: 1, initSize: 8))),
        BlocProvider(
            create: (context) => ServiceLocator.sl<PreferentialBloc>()
              ..add(const PreferentialLoadTopCoupon(quantityTop: 5))),
        BlocProvider(
            create: (context) =>
                ServiceLocator.sl<CartBloc>()..add(CartLoadInformation()))
      ],
      child: RefreshConfiguration(
        footerTriggerDistance: 15,
        dragSpeedRatio: 0.91,
        headerBuilder: () => CustomHeader(
          refreshStyle: RefreshStyle.Follow,
          builder: (context, mode) {
            return const Padding(
              padding: EdgeInsets.all(AppDimen.spacing),
              child: CupertinoActivityIndicator(),
            );
          },
        ),
        footerBuilder: () => ClassicFooter(),
        enableLoadingWhenNoData: false,
        enableRefreshVibrate: false,
        enableLoadMoreVibrate: false,
        shouldFooterFollowWhenNotFull: (state) {
          // If you want load more with noMoreData state ,may be you should return false
          return false;
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) {
            return AppRouter.onGenerateRoute(settings);
          },
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          initialRoute: SplashPage.route,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
