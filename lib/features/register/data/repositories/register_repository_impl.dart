import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/register/data/datasource/register_service.dart';
import 'package:shopfee/features/register/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterService _registerService;

  RegisterRepositoryImpl(this._registerService);

  @override
  Future<bool> checkEmailExist(String email) async {
    try {
      final response = await _registerService.checkEmailExist(email);
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
