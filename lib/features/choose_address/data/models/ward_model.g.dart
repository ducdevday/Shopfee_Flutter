// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ward_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WardModel _$WardModelFromJson(Map<String, dynamic> json) => WardModel(
      districtId: json['district_id'] as String,
      wardId: json['ward_id'] as String,
      wardName: json['ward_name'] as String,
      wardType: json['ward_type'] as String,
    );

Map<String, dynamic> _$WardModelToJson(WardModel instance) => <String, dynamic>{
      'district_id': instance.districtId,
      'ward_id': instance.wardId,
      'ward_name': instance.wardName,
      'ward_type': instance.wardType,
    };
