import 'package:json_annotation/json_annotation.dart';

part 'statistic_spent_detail_model.g.dart';

@JsonSerializable()
class StatisticSpentDetailModel{
  final String time;
  final double amount;

  const StatisticSpentDetailModel({
    required this.time,
    required this.amount,
  });

  factory StatisticSpentDetailModel.fromJson(Map<String, dynamic> json) {
    return _$StatisticSpentDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StatisticSpentDetailModelToJson(this);
  }
}