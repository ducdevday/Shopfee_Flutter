// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_spent_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticSpentModel _$StatisticSpentModelFromJson(Map<String, dynamic> json) =>
    StatisticSpentModel(
      totalSpent: (json['totalSpent'] as num).toDouble(),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) =>
              StatisticSpentDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatisticSpentModelToJson(
        StatisticSpentModel instance) =>
    <String, dynamic>{
      'totalSpent': instance.totalSpent,
      'statistics': instance.statistics,
    };
