

import 'package:shopfee/features/new_password/domain/entities/new_password_entity.dart';

abstract class NewPasswordRepository {
  Future<void> changePassword(NewPasswordEntity newPasswordEntity);
}