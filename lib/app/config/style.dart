import 'package:flutter/material.dart';

import 'color.dart';
import 'dimens.dart';

class AppStyle {
  static final superLargeTitleStyleDark = TextStyle(
    color: AppColor.headingColor,
    fontSize: AppDimen.superLargeTitle,
    fontWeight: FontWeight.bold,
  );

  static final largeTitleStyleDark = TextStyle(
    color: AppColor.headingColor,
    fontSize: AppDimen.largeTitle,
    fontWeight: FontWeight.bold,
  );

  static final mediumTitleStyleDark = TextStyle(
    color: AppColor.headingColor,
    fontSize: AppDimen.mediumTitle,
    fontWeight: FontWeight.bold,
  );
  static final mediumTextStyleDark = TextStyle(
    color: AppColor.paragraphColor,
    fontSize: AppDimen.normalText,
    fontWeight: FontWeight.w500,
  );
  static final normalTextStyleDark = TextStyle(
    color: AppColor.paragraphColor,
    fontSize: AppDimen.normalText,
  );

  static final smallTextStyleDark = TextStyle(
    color: AppColor.paragraphColor,
    fontSize: AppDimen.smallText,
  );

  static final superLargeTitleStyle = TextStyle(
    color: AppColor.lightColor,
    fontSize: AppDimen.superLargeTitle,
    fontWeight: FontWeight.bold,
  );

  static final largeTitleStyle = TextStyle(
    color: AppColor.lightColor,
    fontSize: AppDimen.largeTitle,
    fontWeight: FontWeight.bold,
  );

  static final mediumTitleStyle = TextStyle(
    color: AppColor.lightColor,
    fontSize: AppDimen.mediumTitle,
    fontWeight: FontWeight.bold,
  );

  static final normalTextStyle = TextStyle(
    color: AppColor.lightColor,
    fontSize: AppDimen.normalText,
  );

  static final smallTextStyle = TextStyle(
    color: AppColor.lightColor,
    fontSize: AppDimen.smallText,
  );

  static final superLargeTitleStylePrimary = TextStyle(
    color: AppColor.primaryColor,
    fontSize: AppDimen.superLargeTitle,
    fontWeight: FontWeight.bold,
  );

  static final largeTitleStylePrimary = TextStyle(
    color: AppColor.primaryColor,
    fontSize: AppDimen.largeTitle,
    fontWeight: FontWeight.bold,
  );

  static final mediumTitleStylePrimary = TextStyle(
    color: AppColor.primaryColor,
    fontSize: AppDimen.mediumTitle,
    fontWeight: FontWeight.bold,
  );

  static final normalTextStylePrimary = TextStyle(
    color: AppColor.primaryColor,
    fontSize: AppDimen.normalText,
  );

  static final smallTextStylePrimary = TextStyle(
    color: AppColor.primaryColor,
    fontSize: AppDimen.smallText,
  );

  static final elevatedButtonStylePrimary = ElevatedButton.styleFrom(
      disabledBackgroundColor: const Color(0xffCACACA),
      disabledForegroundColor: AppColor.lightColor,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)));

  static final outlineInputBorderDefault = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xffCCCCCC)),
      borderRadius: BorderRadius.circular(8));

  static final outlineInputBorderPrimary = OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primaryColor),
      borderRadius: BorderRadius.circular(8));
}
