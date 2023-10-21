import 'package:dio/dio.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository_base.dart';

class AuthRepository extends AuthRepositoryBase {
  @override
  Future<Result> register(User user) async {
    Map<String, dynamic> body = {
      "email": user.email,
      "password": user.password,
      "firstName": user.firstName,
      "lastName": user.lastName
    };
    try {
      var response =
          await dio.post("${BaseService.authPath}/register", data: body);
      print(response.data);
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    } catch (e) {
      print(e);
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
  Future<Result> sendCode(String email) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    try {
      var response = await dio
          .post("${BaseService.authPath}/register/send-code", data: body);
      print(response);
      return Result(
          success: response.data["success"], message: response.data["message"]);
    } catch (e) {
      print(e);
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
  Future<bool> verifyCode(String email, String code) async {
    Map<String, dynamic> body = {
      "email": email,
      "code": code,
    };
    try {
      var response =
          await dio.post("${BaseService.authPath}/verify", data: body);
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Result> login(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    try {
      var response =
          await dio.post("${BaseService.authPath}/login", data: body);
      print(response.data);
      return Result(
          success: response.data["success"], message: response.data["message"], data: response.data["data"]);
    } catch (e) {
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> resendCode(String email) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    try {
      var response =
          await dio.post("${BaseService.authPath}/resend-email", data: body);
      print(response.data);
      return Result(
          success: response.data["success"], message: response.data["message"]);
    } catch (e) {
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> passwordSendCode(String email) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    try {
      var response = await dio
          .post("${BaseService.authPath}/password/send-code", data: body);
      print(response.data);
      return Result(
          success: response.data["success"], message: response.data["message"]);
    } catch (e) {
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> changePassword(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };
    try {
      var response = await dio.patch("${BaseService.authPath}/change-password",
          data: body);
      print(response.data);
      return Result(
          success: response.data["success"], message: response.data["message"]);
    } catch (e) {
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> changePasswordInAccount(String oldPassword, String newPassword) async{
    Map<String, dynamic> body = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    try {
      var response = await dio.patch("${BaseService.userPath}/change-password/${GlobalData.ins.userId}",
          data: body);
      print(response.data);
      return Result(
          success: response.data["success"], message: response.data["message"]);
    } catch (e) {
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> refreshToken() async{
    Map<String, dynamic> body = {
      "refreshToken": GlobalData.ins.refreshToken,
    };
    try {
      var response = await dio.patch("${BaseService.authPath}/refresh-token",
          data: body);
      print(response.data);
      return Result(
          success: response.data["success"], message: response.data["message"]);
    } catch (e) {
      return Result(success: false, message: e.toString());
    }
  }
}
