import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class ProductDetailService {
  Future<Response> getProductById(String productId) async {
    final response = await DioService.instance
        .get("${DioService.productPath}/$productId/view");
    return response;
  }
}
