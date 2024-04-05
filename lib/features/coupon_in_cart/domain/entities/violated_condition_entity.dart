import 'package:shopfee/features/coupon_in_cart/data/models/violated_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/min_purchase_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/subject_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/usage_condition_entity.dart';

import 'combination_condition_entity.dart';

class ViolatedConditionEntity {
  final MinPurchaseConditionEntity? minPurchaseCondition;
  final List<UsageConditionEntity>? usageConditionList;
  final List<SubjectConditionEntity>? subjectConditionList;
  final List<CombinationConditionEntity>? combinationConditionList;

  const ViolatedConditionEntity({
    this.minPurchaseCondition,
    this.usageConditionList,
    this.subjectConditionList,
    this.combinationConditionList,
  });

  factory ViolatedConditionEntity.fromModel(ViolatedConditionModel model) {
    return ViolatedConditionEntity(
      minPurchaseCondition: model.minPurchaseCondition == null
          ? null
          : MinPurchaseConditionEntity.fromModel(model.minPurchaseCondition!),
      usageConditionList: model.usageConditionList
          ?.map((e) => UsageConditionEntity.fromModel(e))
          .toList(),
      subjectConditionList: model.subjectConditionList
          ?.map((e) => SubjectConditionEntity.fromModel(e))
          .toList(),
      combinationConditionList: model.combinationConditionList
          ?.map((e) => CombinationConditionEntity.fromModel(e))
          .toList(),
    );
  }
//
}
