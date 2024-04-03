// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) =>
    DistrictModel(
      districtId: json['district_id'] as String?,
      districtName: json['district_name'] as String?,
      districtType: json['district_type'] as String?,
      lat: json['lat'] as num?,
      lng: json['lng'] as num?,
      provinceId: json['province_id'] as String?,
    );

Map<String, dynamic> _$DistrictModelToJson(DistrictModel instance) =>
    <String, dynamic>{
      'district_id': instance.districtId,
      'district_name': instance.districtName,
      'district_type': instance.districtType,
      'lat': instance.lat,
      'lng': instance.lng,
      'province_id': instance.provinceId,
    };
