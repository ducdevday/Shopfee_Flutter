import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/core/base/fcm_service.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';

class VnPayService {
  Future<Response> updateTransaction(String transactionId) async {
    final response = await DioService.instance
        .patch("${DioService.transactionPath}/$transactionId");
    return response;
  }

  Future<Response> addEventLog(String orderId, EventLogModel eventLog) async {
    Map<String, dynamic> body = {
      "orderStatus": eventLog.orderStatus?.name,
      "description": eventLog.description
    };
    final response = await DioService.instance
        .patch("${DioService.orderPath}/user/$orderId", data: body);
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
