import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_list.dart';
import 'package:shopfee/data/repositories/product/product_repository_base.dart';

class ProductRepository extends ProductRepositoryBase {
  @override
  Future<ResultList> getAllProduct() async {
    try {
      var response = await dio.get("${BaseService.productPath}");
      return ResultList(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    } catch (e) {
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }
  @override
  Future<ResultList> getOutStandingProduct({required int quantity}) async {
    try {
      var response = await dio.get("${BaseService.productPath}/top/$quantity");
      return ResultList(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    } catch (e) {
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }
  @override
  Future<Result> getProductById(String id) async {
    try {
      var response = await dio.get("${BaseService.productPath}/$id");
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    } catch (e) {
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<ResultList> getProductsByCategoryId(String id) async{
    try {
      var response = await dio.get("${BaseService.productPath}/category/$id");
      return ResultList(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    } catch (e) {
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }

  @override
  Future<ResultList> getSearchProduct({required String searchString, required int page, required int size}) async
  {
    try {
      Map<String, dynamic> query = {"key":searchString, "page": page, "size": size};
      var response = await dio.get("${BaseService.productPath}", queryParameters: query);
      return ResultList(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    } catch (e) {
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }
}
