// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_check_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponCheckResultModel _$CouponCheckResultModelFromJson(
        Map<String, dynamic> json) =>
    CouponCheckResultModel(
      couponType: $enumDecodeNullable(_$CouponTypeEnumMap, json['couponType']),
      violatedCondition: json['violatedCondition'] == null
          ? null
          : ViolatedConditionModel.fromJson(
              json['violatedCondition'] as Map<String, dynamic>),
      reward: json['reward'] == null
          ? null
          : RewardInformationModel.fromJson(
              json['reward'] as Map<String, dynamic>),
      valid: json['valid'] as bool?,
    );

Map<String, dynamic> _$CouponCheckResultModelToJson(
        CouponCheckResultModel instance) =>
    <String, dynamic>{
      'couponType': _$CouponTypeEnumMap[instance.couponType],
      'violatedCondition': instance.violatedCondition,
      'reward': instance.reward,
      'valid': instance.valid,
    };

const _$CouponTypeEnumMap = {
  CouponType.SHIPPING: 'SHIPPING',
  CouponType.ORDER: 'ORDER',
  CouponType.PRODUCT: 'PRODUCT',
};
