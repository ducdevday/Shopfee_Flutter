import 'package:shopfee/core/common/enum/coupon_usage_type.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/usage_condition_model.dart';

class UsageConditionEntity {
  final CouponUsageConditionType type;
  final num? value;

  const UsageConditionEntity({
    required this.type,
    required this.value,
  });

  factory UsageConditionEntity.fromModel(UsageConditionModel model) {
    return UsageConditionEntity(
      type: model.type,
      value: model.value,
    );
  }
}