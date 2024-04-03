import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/new_password/domain/entities/new_password_entity.dart';
import 'package:shopfee/features/new_password/domain/repositories/new_password_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class NewPasswordUseCase {
  Future<void> changePassword(NewPasswordEntity newPasswordEntity);
}

class NewPasswordUseCaseImpl extends NewPasswordUseCase {
  final NewPasswordRepository _newPasswordRepository;

  NewPasswordUseCaseImpl(this._newPasswordRepository);

  @override
  Future<void> changePassword(NewPasswordEntity newPasswordEntity) async {
    return await _newPasswordRepository.changePassword(newPasswordEntity);
  }
}
