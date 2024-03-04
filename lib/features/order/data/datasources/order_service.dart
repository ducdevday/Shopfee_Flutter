import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/order/data/models/order_query_model.dart';

class OrderService extends BaseService {
  Future<Response> getProductsByCategoryId(String? id,
      {required int page, required int size, OrderQueryModel? query}) async {
    Map<String, dynamic> queryParameters = {
      "page": page,
      "size": size,
      "min_price": query?.minPrice?.toInt(),
      "max_price": query?.maxPrice?.toInt(),
      "min_star": query?.minStar?.toInt(),
      "sort_type": query?.sortType?.toJson(),
    };
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

  Future<Response> getAllCategory() async {
    var response = await dio.get("${BaseService.categoryPath}/visible");
    return response;
  }
}
