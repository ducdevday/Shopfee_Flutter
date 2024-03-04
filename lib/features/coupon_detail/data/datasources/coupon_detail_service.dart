import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';


class CouponDetailService extends BaseService{

  Future<Response> doSomeThing(String query) async{
      final response = await dio.get("path");
      return response;
  }
}