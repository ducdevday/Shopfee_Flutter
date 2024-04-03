import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/coupon_condition_type.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/combination_condition_model.dart';

class CombinationConditionEntity{
  final CouponType type;

  const CombinationConditionEntity({
    required this.type,
  });

  factory CombinationConditionEntity.fromModel(CombinationConditionModel model) {
    return CombinationConditionEntity(
      type: model.type,
    );
  }
}