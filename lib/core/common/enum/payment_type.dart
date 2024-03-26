import 'package:shopfee/core/config/app_path.dart';

enum PaymentType {
  CASHING,
  VNPAY,
  ZALOPAY;

  String toJson() => name;

  static PaymentType fromJson(String json) => values.byName(json);
}
