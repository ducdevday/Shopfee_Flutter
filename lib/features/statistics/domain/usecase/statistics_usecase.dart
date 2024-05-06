import 'package:shopfee/core/common/enum/chart_type.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_order_entity.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_spent_entity.dart';
import 'package:shopfee/features/statistics/domain/repositories/statistics_repository.dart';

abstract class StatisticsUseCase {
  Future<StatisticOrderEntity> getOrderStatistic(
      String userId, ChartType chartType);

  Future<StatisticSpentEntity> getSpentStatistic(
      String userId, DateTime startDate, DateTime endDate);
}

class StatisticsUseCaseImpl extends StatisticsUseCase {
  final StatisticsRepository _statisticsRepository;

  StatisticsUseCaseImpl(this._statisticsRepository);

  @override
  Future<StatisticOrderEntity> getOrderStatistic(
      String userId, ChartType chartType) async {
    return await _statisticsRepository.getOrderStatistic(userId, chartType);
  }

  @override
  Future<StatisticSpentEntity> getSpentStatistic(
      String userId, DateTime startDate, DateTime endDate) async {
    return await _statisticsRepository.getSpentStatistic(
        userId,
        FormatUtil.formattedStatisticDatetimeToString(startDate),
        FormatUtil.formattedStatisticDatetimeToString(endDate));
  }
}
