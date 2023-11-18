import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/cubit/my_bottom_navigation_bar_cubit.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/config/theme.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBottomNavigationBarCubit, MyBottomNavigationBarState>(
        builder: (context, state) {
    if (state is MyBottomNavigationBarLoaded) {
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
                  items: [
                    BottomNavigationBarItem(
                        icon:
                            SvgPicture.asset("assets/icons/ic_home.svg"),
                        activeIcon: SvgPicture.asset(
                            "assets/icons/ic_home_active.svg"),
                        label: "Home"),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            "assets/icons/ic_history.svg"),
                        activeIcon: SvgPicture.asset(
                            "assets/icons/ic_history_active.svg"),
                        label: "History"),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            "assets/icons/ic_account.svg"),
                        activeIcon: SvgPicture.asset(
                            "assets/icons/ic_account_active.svg"),
                        label: "Account")
                  ],
                  currentIndex: state.selectedIndex,
                  iconSize: 24,
                  onTap: (int index) {
                    context.read<MyBottomNavigationBarCubit>().selectPage(index);
                    // switch (index) {
                    //   case 0:
                    //     Navigator.pushNamed(context, AppRouter.homeRoute);
                    //     break;
                    //   case 1:
                    //     Navigator.pushNamed(context,AppRouter.historyRoute);
                    //     break;
                    //   case 2:
                    //     Navigator.pushNamed(context,AppRouter.accountRoute);
                    //     break;
                    //   default:
                    //     Navigator.pushNamed(context, AppRouter.homeRoute);
                    //     break;
                    // }
                  },
                  selectedLabelStyle: AppStyle.smallTextStyle
                      .copyWith(color: AppColor.disableColor),
                  unselectedLabelStyle: AppStyle.smallTextStyle
                      .copyWith(color: AppColor.disableColor),
                  elevation: 5,
                ),
              )));
    } else {
      return const SizedBox();
    }
        },
      );
  }
}
