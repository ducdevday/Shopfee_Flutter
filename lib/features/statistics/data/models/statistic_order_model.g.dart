// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticOrderModel _$StatisticOrderModelFromJson(Map<String, dynamic> json) =>
    StatisticOrderModel(
      total: (json['total'] as num).toDouble(),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) =>
              StatisticOrderDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticOrderModelToJson(
        StatisticOrderModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'statistics': instance.statistics,
    };
