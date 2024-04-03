import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/order_group_model.dart';

class CouponInCartService {
  Future<Response> getCouponListInCart(
      CartModel cart, double totalItemPrice, double totalCartPrice) async {
    Map<String, dynamic> body = {
      "orderItemList": OrderGroupModel.groupOrders(cart.orders)
          .map((e) => e.toJson())
          .toList(),
      "shippingFee": cart.shippingFee,
      "totalItemPrice": totalItemPrice,
      "totalPayment": totalCartPrice,
    };
    final response = await DioService.instance
        .post("${DioService.couponPath}/check-coupon", data: body);
    return response;
  }
}
