import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_usage_type.dart';

part "usage_condition_model.g.dart";

@JsonSerializable()
class UsageConditionModel {
  final CouponUsageConditionType type;
  final num? value;

  const UsageConditionModel({
    required this.type,
    required this.value,
  });

  factory UsageConditionModel.fromJson(Map<String, dynamic> json) {
    return _$UsageConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UsageConditionModelToJson(this);
  }
}