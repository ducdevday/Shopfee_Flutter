// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponConditionModel _$CouponConditionModelFromJson(
        Map<String, dynamic> json) =>
    CouponConditionModel(
      type: $enumDecodeNullable(_$ConditionTypeEnumMap, json['type']),
      minPurchaseCondition: json['minPurchaseCondition'] == null
          ? null
          : MinPurchaseConditionModel.fromJson(
              json['minPurchaseCondition'] as Map<String, dynamic>),
      usageConditionList: (json['usageConditionList'] as List<dynamic>?)
          ?.map((e) => UsageConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      subjectConditionList: (json['subjectConditionList'] as List<dynamic>?)
          ?.map(
              (e) => SubjectConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      combinationConditionList:
          (json['combinationConditionList'] as List<dynamic>?)
              ?.map((e) =>
                  CombinationConditionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CouponConditionModelToJson(
        CouponConditionModel instance) =>
    <String, dynamic>{
      'type': _$ConditionTypeEnumMap[instance.type],
      'minPurchaseCondition': instance.minPurchaseCondition,
      'usageConditionList': instance.usageConditionList,
      'subjectConditionList': instance.subjectConditionList,
      'combinationConditionList': instance.combinationConditionList,
    };

const _$ConditionTypeEnumMap = {
  ConditionType.MIN_PURCHASE: 'MIN_PURCHASE',
  ConditionType.COMBINATION: 'COMBINATION',
  ConditionType.APPLICABLE_CUSTOMER: 'APPLICABLE_CUSTOMER',
  ConditionType.USAGE: 'USAGE',
  ConditionType.TARGET_OBJECT: 'TARGET_OBJECT',
};
