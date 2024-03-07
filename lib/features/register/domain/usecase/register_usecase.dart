import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:shopfee/features/register/domain/repository/register_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class RegisterUseCase {
  Future<bool> checkEmailExist(String email);
}

class RegisterUseCaseImpl extends RegisterUseCase {
  final RegisterRepository _registerRepository;

  RegisterUseCaseImpl(this._registerRepository);

  @override
  Future<bool> checkEmailExist(String email) async {
    return _registerRepository.checkEmailExist(email);
  }
}
