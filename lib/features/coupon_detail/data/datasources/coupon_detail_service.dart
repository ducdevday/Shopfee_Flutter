import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';


class CouponDetailService{

  Future<Response> getCouponDetail(String couponId) async{
      final response = await DioService.instance.get("${DioService.couponPath}/release/$couponId");
      return response;
  }
}