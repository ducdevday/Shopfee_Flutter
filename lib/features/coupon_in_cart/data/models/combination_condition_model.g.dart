// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combination_condition_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombinationConditionModel _$CombinationConditionModelFromJson(
        Map<String, dynamic> json) =>
    CombinationConditionModel(
      type: $enumDecode(_$CouponTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CombinationConditionModelToJson(
        CombinationConditionModel instance) =>
    <String, dynamic>{
      'type': _$CouponTypeEnumMap[instance.type]!,
    };

const _$CouponTypeEnumMap = {
  CouponType.SHIPPING: 'SHIPPING',
  CouponType.ORDER: 'ORDER',
  CouponType.PRODUCT: 'PRODUCT',
};
