import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/core/base/fcm_service.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/order_group_model.dart';

class CartService {
  Future<Response> getAllAddress(String userId) async {
    final response =
        await DioService.instance.get("${DioService.addressPath}/user/$userId");
    return response;
  }

  Future<Response> getAddressDetail(String addressId) async {
    var response =
        await DioService.instance.get("${DioService.addressPath}/$addressId");
    return response;
  }

  Future<Response> createShippingOrder(CartModel cart, String userId, double totalCartPrice) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "itemList": OrderGroupModel.groupOrders(cart.orders).map((e) => e.toJson()).toList(),
      "note": cart.note,
      "addressId": cart.address?.id,
      "shippingFee":cart.shippingFee,
      "paymentType": cart.paymentType!.name,
      "total": totalCartPrice,
      "coin": cart.coin
    };
    print(body);
    final response =
        await DioService.instance.post("${DioService.orderPath}/shipping", data: body);
    return response;
  }

  Future<Response> createTakeAwayOrder(CartModel cart, String userId, double totalCartPrice) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "itemList": OrderGroupModel.groupOrders(cart.orders).map((e) => e.toJson()).toList(),
      "note": cart.note,
      "paymentType": cart.paymentType!.name,
      "receiveTime": cart.receiveTime?.toIso8601String(),
      "branchId": cart.store?.id,
      "total": totalCartPrice,
      "coin": cart.coin
    };
    final response =
        await DioService.instance.post("${DioService.orderPath}/onsite", data: body);
    return response;
  }

  Future<Response> getNearestStore(double latitude, double longitude,String time) async {
    Map<String, dynamic> queryParameters = {
      "lat": latitude,
      "lng": longitude,
      "time": time,
    };
    final response =
    await DioService.instance.get("${DioService.branchPath}/nearest", queryParameters: queryParameters);
    // final response =
    //     await DioService.instance.get("${DioService.branchPath}/1/view");
    return response;
  }

  Future<Response> getShippingFee(double latitude, double longitude) async {
    Map<String, dynamic> queryParameters = {
      "lat": latitude,
      "lng": longitude,
    };
    final response =
    await DioService.instance.get("${DioService.orderPath}/shipping-fee", queryParameters: queryParameters);
    return response;
  }

  Future<Response> getDetailStore(String branchId) async {
    final response = await DioService.instance
        .get("${DioService.branchPath}/$branchId/view");
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
