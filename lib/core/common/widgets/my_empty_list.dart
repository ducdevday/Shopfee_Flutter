import 'package:flutter/cupertino.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_style.dart';

class MyEmptyList extends StatelessWidget {
  final String imgPath;
  final String text;

  const MyEmptyList({Key? key, required this.imgPath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: 60,
          height: 60,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          text,
          style: AppStyle.mediumTextStyleDark
              .copyWith(color: AppColor.nonactiveColor),
        )
      ],
    );
  }
}
