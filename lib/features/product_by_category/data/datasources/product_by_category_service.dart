import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class ProductByCategoryService extends BaseService {
  Future<Response> getProductsByCategoryId(String? id,
      {required int page, required int size}) async {
    Map<String, dynamic> queryParameters = {"page": page, "size": size};
    if (id != null) {
      var response = await dio.get("${BaseService.productPath}/category/$id",
          queryParameters: queryParameters);
      return response;
    } else {
      var response = await dio.get("${BaseService.productPath}/visible",
          queryParameters: queryParameters);
      return response;
    }
  }
}
