import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class SearchService extends BaseService {
  Future<Response> getSearchProduct(
      String searchString, int page, int size) async {
    Map<String, dynamic> query = {
      "key": searchString,
      "page": page,
      "size": size
    };
    final response =
        await dio.get("${BaseService.productPath}/visible", queryParameters: query);
    return response;
  }
}
