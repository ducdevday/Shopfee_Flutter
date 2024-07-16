import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/money_reward_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/product_reward_model.dart';
import 'package:shopfee/features/coupon_in_cart/data/models/subject_reward_model.dart';

part "reward_information_model.g.dart";

@JsonSerializable()
class RewardInformationModel {
  final List<ProductRewardModel>? productRewardList;
  final MoneyRewardModel? moneyReward;
  final List<SubjectRewardModel>? subjectInformationList;

  const RewardInformationModel({
    this.productRewardList,
    this.moneyReward,
    this.subjectInformationList,
  });

  factory RewardInformationModel.fromJson(Map<String, dynamic> json) {
    return _$RewardInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RewardInformationModelToJson(this);
  }


}
