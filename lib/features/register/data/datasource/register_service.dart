import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class RegisterService  {
  Future<Response> checkEmailExist(String email) async {
    Map<String, dynamic> queryParameters = {
      "email": email,
    };
    final response = await DioService.instance.get("${DioService.userPath}/registered",
        queryParameters: queryParameters);
    return response;
  }
}
