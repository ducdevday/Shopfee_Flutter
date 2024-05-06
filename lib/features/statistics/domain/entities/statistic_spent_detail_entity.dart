import 'package:shopfee/features/statistics/data/models/statistic_spent_detail_model.dart';

class StatisticSpentDetailEntity{
  final String time;
  final double amount;

  const StatisticSpentDetailEntity({
    required this.time,
    required this.amount,
  });

  factory StatisticSpentDetailEntity.fromModel(StatisticSpentDetailModel model) {
    return StatisticSpentDetailEntity(
      time: model.time,
      amount: model.amount,
    );
  }
}