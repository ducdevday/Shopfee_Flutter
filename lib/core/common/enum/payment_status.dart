import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';

enum PaymentStatus {
  PAID,
  UNPAID,
  REFUNDED;

  String toJson() => name;

  static PaymentStatus fromJson(String json) => values.byName(json);

  static String getFormattedName(PaymentStatus paymentStatus) {
    switch (paymentStatus) {
      case PaymentStatus.PAID:
        return "Paid";
      case PaymentStatus.UNPAID:
        return "Unpaid";
      case PaymentStatus.REFUNDED:
        return "Refunded";
    }
  }

  static Color getColor(PaymentStatus paymentStatus) {
    switch (paymentStatus) {
      case PaymentStatus.PAID:
        return AppColor.success;
      case PaymentStatus.UNPAID:
        return AppColor.warning;
      case PaymentStatus.REFUNDED:
        return AppColor.info;
    }
  }
}
