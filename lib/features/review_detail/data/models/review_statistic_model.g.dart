// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_statistic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewStatisticModel _$ReviewStatisticModelFromJson(
        Map<String, dynamic> json) =>
    ReviewStatisticModel(
      reviewCountTotal: json['reviewCountTotal'] as int,
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) =>
              ReviewStatisticDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewStatisticModelToJson(
        ReviewStatisticModel instance) =>
    <String, dynamic>{
      'reviewCountTotal': instance.reviewCountTotal,
      'statistics': instance.statistics,
    };
