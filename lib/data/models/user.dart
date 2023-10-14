import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/address.dart';

enum Gender {
  FEMALE,
  MALE,
  OTHER,

}

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

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'lastName': this.lastName,
      // 'email': this.email,
      // 'password': this.password,
      'gender': this.gender?.name,
      'birthDate': this.birthDate?.toIso8601String(),
      'phoneNumber': this.phoneNumber,
      // 'address': this.address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      gender: map['gender'] as Gender?,
      birthDate: map['birthDate'] as DateTime?,
      phoneNumber: map['phoneNumber'] as String?,
      // address: map['address'] as List<Address>,
    );
  }
}