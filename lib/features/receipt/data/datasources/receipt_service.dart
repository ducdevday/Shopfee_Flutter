import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/core/base/fcm_service.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';

class ReceiptService {
  Future<Response> getDetailsOrder(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/$orderId/details");
    return response;
  }

  Future<Response> getEventLogsOrder(String orderId) async {
    final response = await DioService.instance
        .get("${DioService.orderPath}/$orderId/status-line");
    return response;
  }

  Future<Response> cancelOrder(String orderId, String reason) async {
    Map<String, dynamic> body = {"description": reason};
    final response = await DioService.instance
        .patch("${DioService.orderPath}/$orderId/user/cancel", data: body);
    return response;
  }

  Future<Response> requestCancelOrder(String orderId, String reason) async {
    Map<String, dynamic> body = {"reason": reason};
    final response = await DioService.instance.post(
        "${DioService.orderPath}/$orderId/cancellation-request",
        data: body);
    return response;
  }

  Future<void> sendOrderMessage(
    String title,
    String body,
    String destinationId,
  ) async {
    try {
      Map<String, dynamic> data = {
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "status": "done",
          "body": body,
          "title": title,
          "destinationId": destinationId
        },
        "notification": {
          "title": title,
          "body": body,
          "android_channel_id": "shopfee"
        },
        "to": "/topics/orders"
      };
      await FCMService.instance.post("${FCMService.FCM_PATH}", data: data);
    } catch (e) {
      print(e);
    }
  }
}
