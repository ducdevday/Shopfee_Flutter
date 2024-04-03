import 'package:dio/dio.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/new_password/data/datasources/new_password_service.dart';
import 'package:shopfee/features/new_password/data/models/new_password_model.dart';
import 'package:shopfee/features/new_password/domain/entities/new_password_entity.dart';
import 'package:shopfee/features/new_password/domain/repositories/new_password_repository.dart';

class NewPasswordRepositoryImpl implements NewPasswordRepository {
  final NewPasswordService _newPasswordService;

  NewPasswordRepositoryImpl(this._newPasswordService);

  @override
  Future<void> changePassword(NewPasswordEntity newPasswordEntity) async {
    try {
      final response = await _newPasswordService
          .changePassword(NewPasswordModel.fromEntity(newPasswordEntity));
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 500) {
          throw ServerFailure(message: "Current Password Incorrect");
        }
      }
      rethrow;
    }
  }
}
