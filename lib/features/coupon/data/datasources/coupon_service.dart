import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';


class CouponService {

  Future<Response> getCouponsByType(CouponType type) async {
    Map<String, dynamic> queryParameters = {
      "type": type.name,
    };
    final response = await DioService.instance.get(
        "${DioService.couponPath}/release",
        queryParameters: queryParameters);
    return response;
  }
}