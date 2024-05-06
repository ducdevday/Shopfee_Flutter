import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/core/common/enum/chart_type.dart';

class StatisticsService {
  Future<Response> getOrderStatistic(String userId, ChartType chartType) async {
    Map<String, dynamic> params = {"chart_type": chartType.name};
    final response = await DioService.instance
        .get("${DioService.userPath}/$userId/order-statistics", queryParameters: params);
    return response;
  }

  Future<Response> getSpentStatistic(
      String userId, String startDate, String endDate) async {
    Map<String, dynamic> params = {"start_date": startDate, "end_date": endDate};
    final response = await DioService.instance
        .get("${DioService.userPath}/$userId/spent-statistics", queryParameters: params);
    return response;
  }
}
