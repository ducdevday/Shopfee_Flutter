import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/new_password/data/models/new_password_model.dart';

class NewPasswordService extends BaseService {
  Future<Response> changePassword(NewPasswordModel newPasswordModel) async {
    Map<String, dynamic> body = {
      "oldPassword": newPasswordModel.oldPassword,
      "newPassword": newPasswordModel.newPassword,
    };
    final response = await dio.patch(
        "${BaseService.authPath}/${newPasswordModel.userId}/change-password",
        data: body);
    return response;
  }
}
