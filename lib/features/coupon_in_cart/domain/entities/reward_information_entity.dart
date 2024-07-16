import 'package:shopfee/features/coupon_in_cart/data/models/reward_information_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/money_reward_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/product_reward_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/subject_reward_entity.dart';

class RewardInformationEntity {
  final List<ProductRewardEntity>? productRewardList;
  final MoneyRewardEntity? moneyReward;
  final List<SubjectRewardEntity>? subjectInformationList;

  const RewardInformationEntity({
    this.productRewardList,
    this.moneyReward,
    this.subjectInformationList,
  });

  factory RewardInformationEntity.fromModel(RewardInformationModel model) {
    return RewardInformationEntity(
      productRewardList: model.productRewardList
          ?.map((e) => ProductRewardEntity.fromModel(e))
          .toList(),
      moneyReward: model.moneyReward == null
          ? null
          : MoneyRewardEntity.fromModel(model.moneyReward!),
      subjectInformationList: model.subjectInformationList
          ?.map((e) => SubjectRewardEntity.fromModel(e))
          .toList(),
    );
  }
}
