import 'package:shopfee/features/statistics/data/models/statistic_spent_model.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_spent_detail_entity.dart';

class StatisticSpentEntity {
  final double totalSpent;
  final List<StatisticSpentDetailEntity> statistics;

  const StatisticSpentEntity({
    required this.totalSpent,
    required this.statistics,
  });

  factory StatisticSpentEntity.fromModel(StatisticSpentModel model) {
    return StatisticSpentEntity(
      totalSpent: model.totalSpent,
      statistics: model.statistics
          .map((e) => StatisticSpentDetailEntity.fromModel(e))
          .toList(),
    );
  }
}
