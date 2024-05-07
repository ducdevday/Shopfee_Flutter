// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_statistic_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewStatisticDataModel _$ReviewStatisticDataModelFromJson(
        Map<String, dynamic> json) =>
    ReviewStatisticDataModel(
      star: json['star'] as int,
      count: json['count'] as int,
    );

Map<String, dynamic> _$ReviewStatisticDataModelToJson(
        ReviewStatisticDataModel instance) =>
    <String, dynamic>{
      'star': instance.star,
      'count': instance.count,
    };
