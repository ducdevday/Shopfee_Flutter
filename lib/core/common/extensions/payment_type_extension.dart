import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/config/app_path.dart';

extension PaymentTypeExtension on PaymentType {
  String getIconPath() {
    switch (this) {
      case PaymentType.CASHING:
        return AppPath.icCash;
      case PaymentType.VNPAY:
        return AppPath.icVnPay;
      case PaymentType.ZALOPAY:
        return AppPath.icZaloPay;
    }
  }

  String getFormattedName() {
    switch (this) {
      case PaymentType.CASHING:
        return "Cash";
      case PaymentType.VNPAY:
        return "VnPay";
      case PaymentType.ZALOPAY:
        return "ZaloPay";
    }
  }
}
