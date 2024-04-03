// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_all_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAllParamsModel _$StoreAllParamsModelFromJson(Map<String, dynamic> json) =>
    StoreAllParamsModel(
      all: json['all'] as bool,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      page: json['page'] as int,
      size: json['size'] as int,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$StoreAllParamsModelToJson(
        StoreAllParamsModel instance) =>
    <String, dynamic>{
      'all': instance.all,
      'lat': instance.lat,
      'lng': instance.lng,
      'page': instance.page,
      'size': instance.size,
      'key': instance.key,
    };
