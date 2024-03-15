import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/models/gender.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Gender? gender;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? avatarUrl;
  final num? coin;

  const UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.gender,
      this.birthDate,
      this.phoneNumber,
      this.avatarUrl,
      this.coin});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
        id: userEntity.id,
        firstName: userEntity.firstName,
        lastName: userEntity.lastName,
        email: userEntity.email,
        gender: userEntity.gender,
        birthDate: userEntity.birthDate,
        phoneNumber: userEntity.phoneNumber,
        avatarUrl: userEntity.avatarUrl,
        coin: userEntity.coin);
  }
}
