// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreInformationModel _$StoreInformationModelFromJson(
        Map<String, dynamic> json) =>
    StoreInformationModel(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      name: json['name'] as String?,
      fullAddress: json['fullAddress'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      distance: json['distance'] as String?,
      isValid: json['isValid'] as bool?,
    );

Map<String, dynamic> _$StoreInformationModelToJson(
        StoreInformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'fullAddress': instance.fullAddress,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'distance': instance.distance,
      'isValid': instance.isValid,
    };
