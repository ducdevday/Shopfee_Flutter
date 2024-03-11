import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/change_password/data/models/change_password_model.dart';

class ChangePasswordService {
  Future<Response> changePassword(
      ChangePasswordModel changePasswordModel) async {
    Map<String, dynamic> body = changePasswordModel.toJson();
    final response =
        await DioService.instance.patch("${DioService.authPath}/change-password", data: body);
    return response;
  }
}
