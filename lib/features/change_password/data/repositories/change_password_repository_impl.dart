import 'package:shopfee/features/change_password/data/datasources/change_password_service.dart';
import 'package:shopfee/features/change_password/data/models/change_password_model.dart';
import 'package:shopfee/features/change_password/domain/entities/change_password_entity.dart';
import 'package:shopfee/features/change_password/domain/repositories/change_password_repository.dart';

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordService _changePasswordService;

  ChangePasswordRepositoryImpl(this._changePasswordService);

  @override
  Future<void> changePassword(ChangePasswordEntity changePasswordEntity) async {
    await _changePasswordService
        .changePassword(ChangePasswordModel.fromEntity(changePasswordEntity));
  }
}
