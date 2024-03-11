import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class ProductByCategoryService {
  Future<Response> getProductsByCategoryId(String? id,
      {required int page, required int size}) async {
    Map<String, dynamic> queryParameters = {"page": page, "size": size};
    if (id != null) {
      var response = await DioService.instance.get("${DioService.productPath}/category/$id",
          queryParameters: queryParameters);
      return response;
    } else {
      var response = await DioService.instance.get("${DioService.productPath}/visible",
          queryParameters: queryParameters);
      return response;
    }
  }
}
