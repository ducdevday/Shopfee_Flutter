import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/data/models/address.dart';

part 'user.g.dart';

enum Gender {
  FEMALE,
  MALE,
  OTHER;

  String toJson() => name;

  static Gender fromJson(String json) => values.byName(json);
}

@JsonSerializable()
class User extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final Gender? gender;
  final DateTime? birthDate;
  final String? phoneNumber;

  @override
  List<Object> get props => [firstName, lastName, email];

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    this.gender,
    this.birthDate,
    this.phoneNumber,
  });

  @override
  String toString() {
    return 'User{' +
        ' id: $id,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' email: $email,' +
        ' password: $password,' +
        ' gender: $gender,' +
        ' birthDate: $birthDate,' +
        ' phoneNumber: $phoneNumber,' +
        '}';
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    Gender? gender,
    DateTime? birthDate,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}