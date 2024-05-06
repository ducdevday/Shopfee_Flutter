import 'package:shopfee/core/common/enum/chart_type.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/statistics/data/datasources/statistics_service.dart';
import 'package:shopfee/features/statistics/data/models/statistic_order_model.dart';
import 'package:shopfee/features/statistics/data/models/statistic_spent_model.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_order_entity.dart';
import 'package:shopfee/features/statistics/domain/entities/statistic_spent_entity.dart';
import 'package:shopfee/features/statistics/domain/repositories/statistics_repository.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsService _statisticsService;

  StatisticsRepositoryImpl(this._statisticsService);

  @override
  Future<StatisticOrderEntity> getOrderStatistic(
      String userId, ChartType chartType) async {
    final response =
        await _statisticsService.getOrderStatistic(userId, chartType);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final statisticOrderModel = StatisticOrderModel.fromJson(result.data!);
    final statisticOrderEntity =
        StatisticOrderEntity.fromModel(statisticOrderModel);
    return statisticOrderEntity;
  }

  @override
  Future<StatisticSpentEntity> getSpentStatistic(
      String userId, String startDate, String endDate) async {
    final response =
        await _statisticsService.getSpentStatistic(userId, startDate, endDate);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final statisticSpendModel = StatisticSpentModel.fromJson(result.data!);
    final statisticSpendEntity =
        StatisticSpentEntity.fromModel(statisticSpendModel);
    return statisticSpendEntity;
  }
}
