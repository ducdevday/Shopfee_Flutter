import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/features/login/domain/entities/login_entity.dart';
import 'package:shopfee/features/login/domain/repositories/login_repository.dart';

abstract class LoginUseCase {
  Future<MyToken> login(LoginEntity loginEntity);

  Future<MyToken> loginWithGoogle();
}

class LoginUseCaseImpl extends LoginUseCase {
  final LoginRepository _loginRepository;

  LoginUseCaseImpl(this._loginRepository);

  @override
  Future<MyToken> login(LoginEntity loginEntity) async {
    return await _loginRepository.login(loginEntity);
  }

  @override
  Future<MyToken> loginWithGoogle() async{
    return await _loginRepository.loginWithGoogle();
  }
}
