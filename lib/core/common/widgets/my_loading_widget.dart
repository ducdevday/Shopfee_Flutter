import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';

class MyLoadingWidget extends StatelessWidget {
  const MyLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Lottie.asset(
                AppPath.imgCoffeeLoading,
                width: AppDimen.mediumImageSize,
                height: AppDimen.mediumImageSize,
              ),
              Positioned(
                  bottom: AppDimen.spacing,
                  right: 0,
                  left: AppDimen.spacing,
                  child: Center(
                      child: Text(
                        "Loading...",
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.primaryColor),
                      )))
            ],
          ),
        ],
      ),
    );
  }
}