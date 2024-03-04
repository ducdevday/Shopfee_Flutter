import 'package:shopfee/features/change_password/data/models/change_password_model.dart';

class ChangePasswordEntity {
  final String email;
  final String password;
  final String code;
  const ChangePasswordEntity({required this.email, required this.password,required this.code});

  factory ChangePasswordEntity.fromModel(
      ChangePasswordModel changePasswordModel) {
    return ChangePasswordEntity(
        email: changePasswordModel.email,
        password: changePasswordModel.password, code: changePasswordModel.code);
  }
}
