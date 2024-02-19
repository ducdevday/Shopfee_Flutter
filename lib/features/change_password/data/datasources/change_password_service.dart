import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/change_password/data/models/change_password_model.dart';

class ChangePasswordService extends BaseService {
  Future<Response> changePassword(
      ChangePasswordModel changePasswordModel) async {
    Map<String, dynamic> body = changePasswordModel.toJson();
    final response =
        await dio.patch("${BaseService.authPath}/change-password", data: body);
    return response;
  }
}
