import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/reward_unit.dart';

part 'money_reward_model.g.dart';

@JsonSerializable()
class MoneyRewardModel{
  final RewardUnit? unit;
  final num? value;

  const MoneyRewardModel({
    this.unit,
    this.value,
  });

  factory MoneyRewardModel.fromJson(Map<String, dynamic> json) {
    return _$MoneyRewardModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MoneyRewardModelToJson(this);
  }
}