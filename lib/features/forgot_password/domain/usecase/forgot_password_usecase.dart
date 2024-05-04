import 'package:shopfee/features/forgot_password/domain/repositories/forgot_password_repository.dart';

abstract class ForgotPasswordUseCase {
  Future<bool> checkEmailExist(String email);
}

class ForgotPasswordUseCaseImpl extends ForgotPasswordUseCase {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordUseCaseImpl(this._forgotPasswordRepository);

  @override
  Future<bool> checkEmailExist(String email) async {
    return await _forgotPasswordRepository.checkEmailExist(email);
  }
}
