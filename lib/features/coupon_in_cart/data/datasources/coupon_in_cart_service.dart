import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/order_group_model.dart';

class CouponInCartService {
  Future<Response> getCouponListInCart(
      CartModel cart,
      double totalItemPrice,
      double totalCartPrice,
      String? shippingCouponCode,
      String? orderCouponCode,
      String? productCouponCode) async {
    Map<String, dynamic> body = {
      "orderItemList": OrderGroupModel.groupOrders(cart.orders)
          .map((e) => e.toJson())
          .toList(),
      "shippingFee": cart.shippingFee,
      "totalItemPrice": totalItemPrice,
      "totalPayment": totalCartPrice,
      "shippingCouponCode": shippingCouponCode,
      "orderCouponCode": orderCouponCode,
      "productCouponCode": productCouponCode
    };
    final response = await DioService.instance
        .post("${DioService.couponPath}/get-validate-list", data: body);
    return response;
  }
}
