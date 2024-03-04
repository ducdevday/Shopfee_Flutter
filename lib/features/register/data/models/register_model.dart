import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';

part 'register_model.g.dart';

@JsonSerializable()
class RegisterModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? code;

  const RegisterModel(
      {this.firstName, this.lastName, this.email, this.password, this.code});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return _$RegisterModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RegisterModelToJson(this);
  }

  factory RegisterModel.fromEntity(RegisterEntity entity) {
    return RegisterModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        password: entity.password,
        code: entity.code);
  }
}
