import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/change_password/domain/entities/change_password_entity.dart';

part 'change_password_model.g.dart';

@JsonSerializable()
class ChangePasswordModel {
  final String email;
  final String password;
  final String code;

  const ChangePasswordModel(
      {required this.email, required this.password, required this.code});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChangePasswordModelToJson(this);
  }

  factory ChangePasswordModel.fromEntity(ChangePasswordEntity entity) {
    return ChangePasswordModel(
        email: entity.email, password: entity.password, code: entity.code);
  }
}
