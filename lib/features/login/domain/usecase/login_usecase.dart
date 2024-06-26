import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/features/login/domain/entities/login_entity.dart';
import 'package:shopfee/features/login/domain/repositories/login_repository.dart';

abstract class LoginUseCase {
  Future<bool> checkEmailExist(String email);

  Future<MyToken> login(LoginEntity loginEntity);

  Future<MyToken> loginWithGoogle(String fcmTokenId);
}

class LoginUseCaseImpl extends LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCaseImpl(this._loginRepository);

  @override
  Future<bool> checkEmailExist(String email) async {
    return await _loginRepository.checkEmailExist(email);
  }

  @override
  Future<MyToken> login(LoginEntity loginEntity) async {
    return await _loginRepository.login(loginEntity);
  }

  @override
  Future<MyToken> loginWithGoogle(String fcmTokenId) async {
    return await _loginRepository.loginWithGoogle(fcmTokenId);
  }
}
