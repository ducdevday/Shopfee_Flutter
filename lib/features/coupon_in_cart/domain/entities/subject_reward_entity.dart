import 'package:shopfee/features/coupon_in_cart/data/models/subject_reward_model.dart';

class SubjectRewardEntity {
  final String? id;
  final String? name;

  const SubjectRewardEntity({
    this.id,
    this.name,
  });

  factory SubjectRewardEntity.fromModel(SubjectRewardModel model) {
    return SubjectRewardEntity(
      id: model.id,
      name: model.name,
    );
  }
}
