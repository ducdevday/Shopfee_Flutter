import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';


class ProductDetailService extends BaseService{

  Future<Response> getProductById(String productId) async{
      final response = await dio.get("${BaseService.productPath}/$productId/view");
      return response;
  }
}