import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class ProductByCategoryService extends BaseService {
  Future<Response> getProductsByCategoryId(String id) async {
    var response = await dio.get("${BaseService.productPath}/category/$id");
    return response;
  }
}