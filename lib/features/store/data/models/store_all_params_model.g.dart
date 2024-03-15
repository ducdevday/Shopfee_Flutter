// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_all_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreAllParamsModel _$StoreAllParamsModelFromJson(Map<String, dynamic> json) =>
    StoreAllParamsModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$StoreAllParamsModelToJson(
        StoreAllParamsModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'page': instance.page,
      'size': instance.size,
    };
