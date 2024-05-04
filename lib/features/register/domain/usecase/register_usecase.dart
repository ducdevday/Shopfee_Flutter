import 'package:shopfee/features/register/domain/repository/register_repository.dart';

abstract class RegisterUseCase {
  Future<bool> checkEmailExist(String email);
}

class RegisterUseCaseImpl extends RegisterUseCase {
  final RegisterRepository _registerRepository;

  RegisterUseCaseImpl(this._registerRepository);

  @override
  Future<bool> checkEmailExist(String email) async {
    return await _registerRepository.checkEmailExist(email);
  }
}
