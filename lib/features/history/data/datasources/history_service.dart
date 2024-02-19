import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/core/common/models/order_status.dart';

class HistoryService extends BaseService {
  Future<Response> getHistoryOrder(String userId, OrderStatus orderStatus,
      {required int page, required int size}) async {
    Map<String, dynamic> queryParameters = {
      "orderStatus": orderStatus.name,
      "page": page,
      "size": size
    };
    final response = await dio.get(
        "${BaseService.orderPath}/history/user/$userId",
        queryParameters: queryParameters);
    return response;
  }
}
