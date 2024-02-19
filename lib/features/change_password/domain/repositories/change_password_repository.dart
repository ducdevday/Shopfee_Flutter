import 'package:shopfee/features/change_password/domain/entities/change_password_entity.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class ChangePasswordRepository {
  Future<void> changePassword(ChangePasswordEntity changePasswordEntity);
}