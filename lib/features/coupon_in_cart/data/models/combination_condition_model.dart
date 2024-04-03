import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';

part 'combination_condition_model.g.dart';

@JsonSerializable()
class CombinationConditionModel {
  final CouponType type;

  const CombinationConditionModel({
    required this.type,
  });

  factory CombinationConditionModel.fromJson(Map<String, dynamic> json) {
    return _$CombinationConditionModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CombinationConditionModelToJson(this);
  }
}
