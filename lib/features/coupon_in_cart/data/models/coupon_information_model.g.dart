// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponInformationModel _$CouponInformationModelFromJson(
        Map<String, dynamic> json) =>
    CouponInformationModel(
      couponId: json['couponId'] as String?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      valid: json['valid'] as bool?,
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

Map<String, dynamic> _$CouponInformationModelToJson(
        CouponInformationModel instance) =>
    <String, dynamic>{
      'couponId': instance.couponId,
      'code': instance.code,
      'description': instance.description,
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'valid': instance.valid,
      'minPurchaseCondition': instance.minPurchaseCondition,
      'usageConditionList': instance.usageConditionList,
      'subjectConditionList': instance.subjectConditionList,
      'combinationConditionList': instance.combinationConditionList,
    };
