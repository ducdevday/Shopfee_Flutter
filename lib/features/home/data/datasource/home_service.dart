import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class HomeService extends BaseService {
  Future<Response> getAllCategory() async {
    var response = await dio.get("${BaseService.categoryPath}/visible");

    return response;
  }

  Future<Response> getOutStandingProduct({required int quantity}) async {
    var response = await dio.get("${BaseService.productPath}/top/$quantity");
    return response;
  }
}
