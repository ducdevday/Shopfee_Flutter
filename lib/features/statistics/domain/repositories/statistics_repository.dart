

import 'package:shopfee/core/common/enum/chart_type.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_order_entity.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_spent_entity.dart';

abstract class StatisticsRepository {
  Future<StatisticSpentEntity> getSpentStatistic(String userId, String startDate, String endDate);
  Future<StatisticOrderEntity> getOrderStatistic(String userId, ChartType chartType);
}