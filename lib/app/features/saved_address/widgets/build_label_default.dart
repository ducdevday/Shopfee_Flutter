import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';

Widget buildLabelDefault(bool isDefault) {
  if (isDefault) {
    return OutlinedButton(
        onPressed: null,
        child: Text("Default"),
        style: OutlinedButton.styleFrom(
            minimumSize: const Size(84, 26),
            disabledForegroundColor: AppColor.primaryColor,
            side: const BorderSide(width: 1, color: Color(0xff5D4037))));
  } else {
    return SizedBox();
  }
}