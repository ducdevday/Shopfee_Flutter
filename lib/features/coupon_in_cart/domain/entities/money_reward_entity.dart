import 'package:shopfee/core/common/enum/reward_unit.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/money_reward_model.dart';

class MoneyRewardEntity {
  final RewardUnit? unit;
  final num? value;

  const MoneyRewardEntity({
    this.unit,
    this.value,
  });

  factory MoneyRewardEntity.fromModel(MoneyRewardModel model) {
    return MoneyRewardEntity(
      unit: model.unit,
      value: model.value,
    );
  }
}
