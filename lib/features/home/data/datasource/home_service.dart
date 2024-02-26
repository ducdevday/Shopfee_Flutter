import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class HomeService extends BaseService {
  Future<Response> getAllCategory() async {
    // var response = await dio.get("${BaseService.categoryPath}/visible");
    //TODO: Need to fix
    var response = await dio.get("${BaseService.categoryPath}");

    return response;
  }

  Future<Response> getOutStandingProduct({required int quantity}) async {
    // var response = await dio.get("${BaseService.productPath}/top/$quantity");
    //TODO: Need to fix
    Map<String, dynamic> query = {"page": 1, "size": quantity};
    var response =
        await dio.get("${BaseService.productPath}/visible", queryParameters: query);
    return response;
  }
}
