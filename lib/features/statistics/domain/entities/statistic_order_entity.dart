import 'package:shopfee/features/statistics/data/models/statistic_order_model.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_order_detail_entity.dart';

class StatisticOrderEntity {
  final double total;
  final List<StatisticOrderDetailEntity> statistics;

  const StatisticOrderEntity({
    required this.total,
    required this.statistics,
  });

  factory StatisticOrderEntity.fromModel(StatisticOrderModel model) {
    return StatisticOrderEntity(
      total:model.total,
      statistics: model.statistics.map((e) => StatisticOrderDetailEntity.fromModel(e)).toList(),
    );
  }
//
}
