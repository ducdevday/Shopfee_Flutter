// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_order_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticOrderDetailModel _$StatisticOrderDetailModelFromJson(
        Map<String, dynamic> json) =>
    StatisticOrderDetailModel(
      key: json['key'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$StatisticOrderDetailModelToJson(
        StatisticOrderDetailModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'value': instance.value,
    };
