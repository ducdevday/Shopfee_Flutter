import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class TrackingService extends BaseService {
  Future<Response> getEventLogsOrder(String orderId) async {
    final response = await dio.get("${BaseService.orderPath}/status/$orderId");
    return response;
  }
}
