import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/utils/global_keys.dart';

class AlertUtil {
  static showToast(String message) {
    return scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }
}