// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistic_spent_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticSpentDetailModel _$StatisticSpentDetailModelFromJson(
        Map<String, dynamic> json) =>
    StatisticSpentDetailModel(
      time: json['time'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$StatisticSpentDetailModelToJson(
        StatisticSpentDetailModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'amount': instance.amount,
    };
