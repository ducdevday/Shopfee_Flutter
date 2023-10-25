import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/user/user_repository_base.dart';

class UserRepository extends UserRepositoryBase {
  @override
  Future<Result> getUser(String userId) async {
    try {
      var response = await dio.get(
        "${BaseService.userPath}/$userId",
      );
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
  Future<Result> updateUser(User user) async {
    try {
      var response = await dio.put("${BaseService.userPath}/update/${user.id}",
          data: user.toJson());
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
  Future<Result> checkEmailExist(String email) async {
    Map<String, dynamic> queryParameters = {
      "email": email,
    };
    try {
      var response = await dio.get("${BaseService.userPath}/existed",
          queryParameters: queryParameters);
      return Result(
        success: response.data["success"],
        message: response.data["message"],
      );
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
}
