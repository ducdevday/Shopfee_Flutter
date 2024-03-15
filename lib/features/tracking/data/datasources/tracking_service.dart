import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class TrackingService {
  Future<Response> getEventLogsOrder(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/$orderId/status-line");
    return response;
  }
}
