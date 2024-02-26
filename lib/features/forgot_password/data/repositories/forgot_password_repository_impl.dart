import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/forgot_password/data/datasources/forgot_pasword_service.dart';
import 'package:shopfee/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:shopfee/features/template/data/datasources/template_service.dart';
import 'package:shopfee/features/template/data/models/template_model.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordService _forgotPasswordService;

  ForgotPasswordRepositoryImpl(this._forgotPasswordService);

  @override
  Future<bool> checkEmailExist(String email) async {
    try {
      final response = await _forgotPasswordService.checkEmailExist(email);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
      );
      if (result.success) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
