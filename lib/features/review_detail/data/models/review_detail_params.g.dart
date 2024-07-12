// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_detail_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDetailParams _$ReviewDetailParamsFromJson(Map<String, dynamic> json) =>
    ReviewDetailParams(
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      sortType: json['sort_type'] as String?,
    );

Map<String, dynamic> _$ReviewDetailParamsToJson(ReviewDetailParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'sort_type': instance.sortType,
    };
