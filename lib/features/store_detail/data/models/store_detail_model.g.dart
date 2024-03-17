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
      openTime: json['openTime'] as String?,
      closeTime: json['closeTime'] as String?,
      fullAddress: json['fullAddress'] as String?,
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
      'openTime': instance.openTime,
      'closeTime': instance.closeTime,
      'fullAddress': instance.fullAddress,
      'isValid': instance.isValid,
    };
