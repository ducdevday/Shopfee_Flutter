import 'package:shopfee/core/common/models/gender.dart';
import 'package:shopfee/features/user/data/models/user_model.dart';

class UserEntity {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final Gender? gender;
  final DateTime? birthDate;
  final String? phoneNumber;
  final String? avatarUrl;
  final num? coin;

  const UserEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.birthDate,
    required this.phoneNumber,
    this.avatarUrl,
    this.coin,
  });

  factory UserEntity.fromModel(UserModel userModel) {
    return UserEntity(
        id: userModel.id,
        firstName: userModel.firstName ?? "",
        lastName: userModel.lastName ?? "",
        email: userModel.email ?? "",
        gender: userModel.gender,
        birthDate: userModel.birthDate,
        phoneNumber: userModel.phoneNumber,
        avatarUrl: userModel.avatarUrl,
        coin: userModel.coin ?? 0);
  }
}
