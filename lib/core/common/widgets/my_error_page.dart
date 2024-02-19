import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/navigation_util.dart';

class MyErrorPage extends StatelessWidget {
  const MyErrorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Lottie.asset("assets/images/lottie_coffee_error.json",
                    width: 200, height: 200),
                Text(
                  "Some thing went wrong",
                  style: AppStyle.mediumTextStyleDark.copyWith(height: 1.5),
                ),
                SizedBox(
                  height: AppDimen.spacing,
                ),
                ElevatedButton(
                    onPressed: () {
                      NavigationUtil.pop();
                    },
                    child: const Text("Go Back"),
                    style: AppStyle.elevatedButtonStylePrimary)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
