import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';

class CartService extends BaseService {
  Future<Response> getAllAddress(String userId) async {
    final response = await dio.get("${BaseService.addressPath}/user/$userId");
    return response;
  }

  Future<Response> getAddressDetail(String addressId) async {
    var response = await dio.get("${BaseService.addressPath}/$addressId");
    return response;
  }

  Future<Response> createShippingOrder(CartModel cart, String userId) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "products": cart.orders.map((order) => order.toJsonOrder()).toList(),
      "note": cart.note,
      "paymentType": cart.typePayment!.name,
      "address": cart.address!.toJsonOrder()
    };
    final response = await dio.post("${BaseService.orderPath}", data: body);
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
