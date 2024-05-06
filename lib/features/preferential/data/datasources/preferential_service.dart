import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class PreferentialService {
  Future<Response> getTopCoupons(int quantity) async {
    Map<String, dynamic> queryParameters = {
      "quantity": quantity,
    };
    final response = await DioService.instance.get(
        "${DioService.couponPath}/release",
        queryParameters: queryParameters);
    return response;
  }
}
