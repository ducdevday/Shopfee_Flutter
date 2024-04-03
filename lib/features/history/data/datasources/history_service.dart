import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/history/data/models/order_history_params_model.dart';

class HistoryService{
  Future<Response> getHistoryOrder(String userId, OrderHistoryParamsModel params) async {
    final response = await DioService.instance.get(
        "${DioService.orderPath}/history/user/$userId",
        queryParameters: params.toJson());
    return response;
  }
}
