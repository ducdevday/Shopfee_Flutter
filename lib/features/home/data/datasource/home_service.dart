import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class HomeService {
  Future<Response> getAllCategory() async {
    var response =
        await DioService.instance.get("${DioService.categoryPath}/visible");

    return response;
  }

  Future<Response> getOutStandingProduct({required int quantity}) async {
    var response = await DioService.instance
        .get("${DioService.productPath}/top-rating/$quantity");
    return response;
  }

  Future<Response> getTopSellingProduct({required int quantity}) async {
    var response = await DioService.instance
        .get("${DioService.productPath}/top-selling/$quantity");
    return response;
  }

  Future<Response> getViewedProduct({required int quantity}) async {
    Map<String, dynamic> params = {"size": quantity};

    final response = await DioService.instance.get(
        "${DioService.productPath}/user-tracking",
        queryParameters: params);
    return response;
  }

  Future<Response> getNewestBlog({required int quantity}) async {
    Map<String, dynamic> params = {"page": 1, "size": quantity};

    var response = await DioService.instance
        .get("${DioService.blogPath}/view-list", queryParameters: params);
    return response;
  }

  Future<Response> getAllBanner() async {
    var response =
        await DioService.instance.get("${DioService.bannerPath}/visible");
    return response;
  }
}
