import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class BlogService {
  Future<Response> getBlogs(int page, int size) async {
    Map<String, dynamic> params = {"page": page, "size": size};

    var response = await DioService.instance
        .get("${DioService.blogPath}/view-list", queryParameters: params);
    return response;
  }
}
