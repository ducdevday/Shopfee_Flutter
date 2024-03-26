import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Lottie.asset(AppPath.imgError,
                  width: AppDimen.mediumImageSize, height: AppDimen.mediumImageSize),
              Text(
                "Some thing went wrong",
                style: AppStyle.mediumTextStyleDark.copyWith(height: 1.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
