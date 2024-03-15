import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/config/app_theme.dart';

import 'my_bottom_nav_bar_cubit.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBottomNavBarCubit, int>(
      builder: (context, selectedPage) {
        return Theme(
            data: AppTheme.lightTheme.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 1,
                        blurRadius: 0.5),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  child: BottomNavigationBar(
                    enableFeedback: true,
                    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            AppPath.icHome,
                            colorFilter: ColorFilter.mode(
                                AppColor.nonactiveColor, BlendMode.srcIn),
                          ),
                          activeIcon: SvgPicture.asset(
                            AppPath.icHome,
                            colorFilter: ColorFilter.mode(
                                AppColor.primaryColor, BlendMode.srcIn),
                          ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            AppPath.icOrder,
                            colorFilter: ColorFilter.mode(
                                AppColor.nonactiveColor, BlendMode.srcIn),
                          ),
                          activeIcon: SvgPicture.asset(
                            AppPath.icOrder,
                            colorFilter: ColorFilter.mode(
                                AppColor.primaryColor, BlendMode.srcIn),
                          ),
                          label: "Order"),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            AppPath.icStore,
                            colorFilter: ColorFilter.mode(
                                AppColor.nonactiveColor, BlendMode.srcIn),
                          ),
                          activeIcon: SvgPicture.asset(
                            AppPath.icStore,
                            colorFilter: ColorFilter.mode(
                                AppColor.primaryColor, BlendMode.srcIn),
                          ),
                          label: "Store"),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            AppPath.icPreferential,
                            colorFilter: ColorFilter.mode(
                                AppColor.nonactiveColor, BlendMode.srcIn),
                          ),
                          activeIcon: SvgPicture.asset(
                            AppPath.icPreferential,
                            colorFilter: ColorFilter.mode(
                                AppColor.primaryColor, BlendMode.srcIn),
                          ),
                          label: "Preferential"),
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            AppPath.icMenu,
                            colorFilter: ColorFilter.mode(
                                AppColor.nonactiveColor, BlendMode.srcIn),
                          ),
                          activeIcon: SvgPicture.asset(
                            AppPath.icMenu,
                            colorFilter: ColorFilter.mode(
                                AppColor.primaryColor, BlendMode.srcIn),
                          ),
                          label: "Others")
                    ],
                    currentIndex: selectedPage,
                    iconSize: 24,
                    onTap: (int index) {
                      context.read<MyBottomNavBarCubit>().selectPage(index);
                    },
                    selectedLabelStyle: AppStyle.smallTextStyle
                        .copyWith(color: AppColor.disableColor),
                    unselectedLabelStyle: AppStyle.smallTextStyle
                        .copyWith(color: AppColor.disableColor),
                    elevation: 5,
                  ),
                )));
      },
    );
  }
}
