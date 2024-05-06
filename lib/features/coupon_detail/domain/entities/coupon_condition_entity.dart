import 'package:shopfee/core/common/enum/coupon_condition_type.dart';
import 'package:shopfee/features/coupon_detail/data/models/coupon_condition_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/combination_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/min_purchase_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/subject_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/usage_condition_entity.dart';

class CouponConditionEntity {
  final ConditionType? type;
  final MinPurchaseConditionEntity? minPurchaseCondition;
  final List<UsageConditionEntity>? usageConditionList;
  final List<SubjectConditionEntity>? subjectConditionList;
  final List<CombinationConditionEntity>? combinationConditionList;

  const CouponConditionEntity({
    this.type,
    this.minPurchaseCondition,
    this.usageConditionList,
    this.subjectConditionList,
    this.combinationConditionList,
  });

  factory CouponConditionEntity.fromModel(CouponConditionModel model) {
    return CouponConditionEntity(
      type: model.type,
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
