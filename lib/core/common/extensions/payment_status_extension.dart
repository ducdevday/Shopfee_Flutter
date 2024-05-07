import 'dart:ui';

import 'package:shopfee/core/common/enum/payment_status.dart';
import 'package:shopfee/core/config/app_color.dart';

extension PaymentStatusExtension on PaymentStatus{
   String getFormattedName() {
    switch (this) {
      case PaymentStatus.PAID:
        return "Paid";
      case PaymentStatus.UNPAID:
        return "Unpaid";
      case PaymentStatus.FAILED:
        return "Failed";
    }
  }

   Color getColor() {
    switch (this) {
      case PaymentStatus.PAID:
        return AppColor.success;
      case PaymentStatus.UNPAID:
        return AppColor.warning;
      case PaymentStatus.FAILED:
        return AppColor.info;
    }
  }
}