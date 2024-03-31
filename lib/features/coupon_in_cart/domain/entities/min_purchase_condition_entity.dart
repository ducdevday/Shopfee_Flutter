import 'package:shopfee/features/coupon_in_cart/data/models/min_purchase_condition_model.dart';

class MinPurchaseConditionEntity{
  final num value;

  const MinPurchaseConditionEntity({
    required this.value,
  });

  factory MinPurchaseConditionEntity.fromModel(MinPurchaseConditionModel model) {
    return MinPurchaseConditionEntity(
      value: model.value,
    );
  }
//
}


