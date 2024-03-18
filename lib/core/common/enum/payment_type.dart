import 'package:shopfee/core/config/app_path.dart';

enum PaymentType {
  CASHING,
  VNPAY,
  ZALOPAY;

  String toJson() => name;

  static PaymentType fromJson(String json) => values.byName(json);

  static String getIconPath(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.CASHING:
        return AppPath.icCash;
      case PaymentType.VNPAY:
        return AppPath.icVnPay;
      case PaymentType.ZALOPAY:
        return AppPath.icZaloPay;
    }
  }

  static String getFormattedName(PaymentType paymentType) {
    switch (paymentType) {
      case PaymentType.CASHING:
        return "Cash";
      case PaymentType.VNPAY:
        return "VnPay";
      case PaymentType.ZALOPAY:
        return "ZaloPay";
    }
  }
}
