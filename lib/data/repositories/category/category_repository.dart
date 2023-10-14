import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result_list.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/repositories/category/category_repository_base.dart';

class CategoryRepository extends CategoryRepositoryBase {
  @override
  Future<ResultList> getAllCategory() async {
    try {
      var response = await dio.get("${BaseService.categoryPath}");
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
