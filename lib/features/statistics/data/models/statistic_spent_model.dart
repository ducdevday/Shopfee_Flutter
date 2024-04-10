import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/statistics/data/models/statistic_spent_detail_model.dart';

part 'statistic_spent_model.g.dart';

@JsonSerializable()
class StatisticSpentModel{
  final double totalSpent;
  final List<StatisticSpentDetailModel> statistics;

  const StatisticSpentModel({
    required this.totalSpent,
    required this.statistics,
  });

  factory StatisticSpentModel.fromJson(Map<String, dynamic> json) {
    return _$StatisticSpentModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatisticSpentModelToJson(this);
  }
}