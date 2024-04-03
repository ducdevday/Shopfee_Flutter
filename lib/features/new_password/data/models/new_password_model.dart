import 'package:shopfee/features/new_password/domain/entities/new_password_entity.dart';

class NewPasswordModel {
  final String userId;
  final String oldPassword;
  final String newPassword;

  Map<String, dynamic> toJson() {
    return {
      "userId": this.userId,
      "oldPassword": this.oldPassword,
      "newPassword": this.newPassword,
    };
  }

  factory NewPasswordModel.fromEntity(NewPasswordEntity entity) {
    return NewPasswordModel(
        userId: entity.userId,
        oldPassword: entity.oldPassword,
        newPassword: entity.newPassword);
  }

  const NewPasswordModel({
    required this.userId,
    required this.oldPassword,
    required this.newPassword,
  });
}
