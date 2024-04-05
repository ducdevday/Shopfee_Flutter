// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponDetailModel _$CouponDetailModelFromJson(Map<String, dynamic> json) =>
    CouponDetailModel(
      code: json['code'] as String?,
      type: $enumDecodeNullable(_$CouponTypeEnumMap, json['type']),
      description: json['description'] as String?,
      conditionList: (json['conditionList'] as List<dynamic>?)
          ?.map((e) => CouponConditionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
    );

Map<String, dynamic> _$CouponDetailModelToJson(CouponDetailModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'type': _$CouponTypeEnumMap[instance.type],
      'description': instance.description,
      'conditionList': instance.conditionList,
      'startDate': instance.startDate?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
    };

const _$CouponTypeEnumMap = {
  CouponType.SHIPPING: 'SHIPPING',
  CouponType.ORDER: 'ORDER',
  CouponType.PRODUCT: 'PRODUCT',
};
