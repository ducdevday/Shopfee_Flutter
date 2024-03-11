import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class SearchService {
  Future<Response> getSearchProduct(
      String searchString, int page, int size) async {
    Map<String, dynamic> query = {
      "key": searchString,
      "page": page,
      "size": size
    };
    final response = await DioService.instance
        .get("${DioService.productPath}/visible", queryParameters: query);
    return response;
  }
}
