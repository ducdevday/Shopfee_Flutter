// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'province_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProvinceModel _$ProvinceModelFromJson(Map<String, dynamic> json) =>
    ProvinceModel(
      provinceId: json['province_id'] as String?,
      provinceName: json['province_name'] as String?,
      provinceType: json['province_type'] as String?,
    );

Map<String, dynamic> _$ProvinceModelToJson(ProvinceModel instance) =>
    <String, dynamic>{
      'province_id': instance.provinceId,
      'province_name': instance.provinceName,
      'province_type': instance.provinceType,
    };
