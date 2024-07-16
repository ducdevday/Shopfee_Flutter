import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class ProductDetailService {
  Future<Response> getProductById(String productId) async {
    final response = await DioService.instance
        .get("${DioService.productPath}/$productId/view");
    return response;
  }

  Future<Response> getViewedProduct(int size) async {
    Map<String, dynamic> params = {"size": size};

    final response = await DioService.instance.get(
        "${DioService.productPath}/user-tracking",
        queryParameters: params);
    return response;
  }

  Future<Response> getRecommendProduct(String userId, int quantity) async {
    Map<String, dynamic> params = {"user_id": userId, "quantity": quantity};

    final response = await DioService.instance
        .get("${DioService.productPath}/recommend", queryParameters: params);
    return response;
  }
}
