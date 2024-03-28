// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewParams _$ReviewParamsFromJson(Map<String, dynamic> json) => ReviewParams(
      orderItemId: json['orderItemId'] as String,
      star: json['star'] as int,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ReviewParamsToJson(ReviewParams instance) =>
    <String, dynamic>{
      'orderItemId': instance.orderItemId,
      'star': instance.star,
      'content': instance.content,
    };
