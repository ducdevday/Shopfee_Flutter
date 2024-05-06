import 'package:shopfee/features/coupon_in_cart/data/models/coupon_information_model.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/combination_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/min_purchase_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/subject_condition_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/usage_condition_entity.dart';

class CouponInformationEntity {
  final String? couponId;
  final String? code;
  final String? description;
  final DateTime? expirationDate;
  final bool? valid;
  final MinPurchaseConditionEntity? minPurchaseCondition;
  final List<UsageConditionEntity>? usageConditionList;
  final List<SubjectConditionEntity>? subjectConditionList;
  final List<CombinationConditionEntity>? combinationConditionList;

  const CouponInformationEntity({
    this.couponId,
    this.code,
    this.description,
    this.expirationDate,
    this.valid,
    this.minPurchaseCondition,
    this.usageConditionList,
    this.subjectConditionList,
    this.combinationConditionList,
  }); //

  factory CouponInformationEntity.fromModel(CouponInformationModel model) {
    return CouponInformationEntity(
      couponId: model.couponId,
      code: model.code,
      description: model.description,
      expirationDate: model.expirationDate,
      valid: model.valid,
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

  CouponInformationEntity copyWith({
    String? couponId,
    String? code,
    String? description,
    DateTime? expirationDate,
    bool? valid,
    MinPurchaseConditionEntity? minPurchaseCondition,
    List<UsageConditionEntity>? usageConditionList,
    List<SubjectConditionEntity>? subjectConditionList,
    List<CombinationConditionEntity>? combinationConditionList,
  }) {
    return CouponInformationEntity(
      couponId: couponId ?? this.couponId,
      code: code ?? this.code,
      description: description ?? this.description,
      expirationDate: expirationDate ?? this.expirationDate,
      valid: valid ?? this.valid,
      minPurchaseCondition: minPurchaseCondition ?? this.minPurchaseCondition,
      usageConditionList: usageConditionList ?? this.usageConditionList,
      subjectConditionList: subjectConditionList ?? this.subjectConditionList,
      combinationConditionList:
          combinationConditionList ?? this.combinationConditionList,
    );
  }
}
