import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';

enum PaymentStatus {
  PAID,
  UNPAID,
  REFUNDED;

  String toJson() => name;

  static PaymentStatus fromJson(String json) => values.byName(json);
}
