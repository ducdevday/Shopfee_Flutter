import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class BlogDetailService {
  Future<Response> getBlogDetail(String blogId) async {
    var response =
        await DioService.instance.get("${DioService.blogPath}/${blogId}/view");
    return response;
  }
}
