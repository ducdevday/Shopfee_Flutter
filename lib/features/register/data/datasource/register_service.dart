import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class RegisterService extends BaseService {
  Future<Response> checkEmailExist(String email) async {
    Map<String, dynamic> queryParameters = {
      "email": email,
    };
    final response = await dio.get("${BaseService.userPath}/registered",
        queryParameters: queryParameters);
    return response;
  }
}
