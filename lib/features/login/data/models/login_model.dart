import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/login/domain/entities/login_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String? email;
  final String? password;

  const LoginModel({
    this.email,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginModelToJson(this);
  }

  factory LoginModel.fromEntity(LoginEntity loginEntity) {
    return LoginModel(email: loginEntity.email, password: loginEntity.password);
  }
}
