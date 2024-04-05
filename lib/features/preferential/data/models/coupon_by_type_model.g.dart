// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_by_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponByTypeModel _$CouponByTypeModelFromJson(Map<String, dynamic> json) =>
    CouponByTypeModel(
      id: json['id'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      expirationDate: json['expirationDate'] == null
          ? null
          : DateTime.parse(json['expirationDate'] as String),
      type: $enumDecodeNullable(_$CouponTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$CouponByTypeModelToJson(CouponByTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'expirationDate': instance.expirationDate?.toIso8601String(),
      'type': _$CouponTypeEnumMap[instance.type],
    };

const _$CouponTypeEnumMap = {
  CouponType.SHIPPING: 'SHIPPING',
  CouponType.ORDER: 'ORDER',
  CouponType.PRODUCT: 'PRODUCT',
};
