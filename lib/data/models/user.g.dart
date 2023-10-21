// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      birthDate: json['birthDate'] == null
          ? null
          : DateTime.parse(json['birthDate'] as String),
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'gender': instance.gender,
      'birthDate': instance.birthDate?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
    };

const _$GenderEnumMap = {
  Gender.FEMALE: 'FEMALE',
  Gender.MALE: 'MALE',
  Gender.OTHER: 'OTHER',
};
