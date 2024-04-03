import 'package:shopfee/features/change_password/domain/entities/change_password_entity.dart';
import 'package:shopfee/features/change_password/domain/repositories/change_password_repository.dart';

abstract class ChangePasswordUseCase{
  Future<void> changePassword(ChangePasswordEntity changePasswordEntity);
}

class ChangePasswordUseCaseImpl extends ChangePasswordUseCase{
  final ChangePasswordRepository _changePasswordRepository;

  ChangePasswordUseCaseImpl(this._changePasswordRepository);

  @override
  Future<void> changePassword(ChangePasswordEntity changePasswordEntity) async{
    await _changePasswordRepository.changePassword(changePasswordEntity);
  }

}