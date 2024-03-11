import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/core/common/models/order_status.dart';

class HistoryService{
  Future<Response> getHistoryOrder(String userId, OrderStatus orderStatus,
      {required int page, required int size}) async {
    Map<String, dynamic> queryParameters = {
      "orderStatus": orderStatus.name,
      "page": page,
      "size": size
    };
    final response = await DioService.instance.get(
        "${DioService.orderPath}/history/user/$userId",
        queryParameters: queryParameters);
    return response;
  }
}
