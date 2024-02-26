import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class ForgotPasswordUseCase {
  Future<bool> checkEmailExist(String email);
}

class ForgotPasswordUseCaseImpl extends ForgotPasswordUseCase {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordUseCaseImpl(this._forgotPasswordRepository);

  @override
  Future<bool> checkEmailExist(String email) async {
    return _forgotPasswordRepository.checkEmailExist(email);
  }
}
