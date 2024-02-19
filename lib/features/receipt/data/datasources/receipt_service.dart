import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/receipt/data/models/event_log_model.dart';

class ReceiptService extends BaseService {
  Future<Response> getDetailsOrder(String orderId) async {
    final response = await dio.get("${BaseService.orderPath}/details/$orderId");
    return response;
  }

  Future<Response> getEventLogsOrder(String orderId) async {
    final response = await dio.get("${BaseService.orderPath}/status/$orderId");
    return response;
  }

  Future<Response> addEventLog(String orderId, EventLogModel eventLog) async {
    Map<String, dynamic> body = {
      "orderStatus": eventLog.orderStatus?.name,
      "description": eventLog.description
    };
    final response =
        await dio.patch("${BaseService.orderPath}/user/$orderId", data: body);

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
      await dioNotify.post("${BaseService.NOTIFY_PATH}", data: data);
    } catch (e) {
      print(e);
    }
  }
}
