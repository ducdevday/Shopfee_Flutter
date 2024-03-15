// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDetailModel _$StoreDetailModelFromJson(Map<String, dynamic> json) =>
    StoreDetailModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      province: json['province'] as String?,
      district: json['district'] as String?,
      ward: json['ward'] as String?,
      detail: json['detail'] as String?,
      openTime: json['openTime'] as String?,
      closeTime: json['closeTime'] as String?,
      status: $enumDecodeNullable(_$StoreStatusEnumMap, json['status']),
      isValid: json['isValid'] as bool?,
    );

Map<String, dynamic> _$StoreDetailModelToJson(StoreDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'imageUrl': instance.imageUrl,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'province': instance.province,
      'district': instance.district,
      'ward': instance.ward,
      'detail': instance.detail,
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'status': instance.status,
      'isValid': instance.isValid,
    };

const _$StoreStatusEnumMap = {
  StoreStatus.ACTIVE: 'ACTIVE',
  StoreStatus.UNACTIVE: 'UNACTIVE',
};
