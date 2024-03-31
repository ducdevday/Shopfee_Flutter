// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) => LoginModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      fcmTokenId: json['fcmTokenId'] as String?,
    );

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'fcmTokenId': instance.fcmTokenId,
    };
