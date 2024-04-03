// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usage_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsageConditionModel _$UsageConditionModelFromJson(Map<String, dynamic> json) =>
    UsageConditionModel(
      type: $enumDecode(_$CouponUsageConditionTypeEnumMap, json['type']),
      value: json['value'] as num,
    );

Map<String, dynamic> _$UsageConditionModelToJson(
        UsageConditionModel instance) =>
    <String, dynamic>{
      'type': _$CouponUsageConditionTypeEnumMap[instance.type]!,
      'value': instance.value,
    };

const _$CouponUsageConditionTypeEnumMap = {
  CouponUsageConditionType.QUANTITY: 'QUANTITY',
  CouponUsageConditionType.LIMIT_ONE_FOR_USER: 'LIMIT_ONE_FOR_USER',
};
