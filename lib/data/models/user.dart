import 'package:equatable/equatable.dart';
import 'package:shopfee/data/models/adress.dart';

enum Gender {
  FEMALE,
  MALE,
  OTHER,
}

enum Role {
  ROLE_USER,
  ROLE_ADMIN,
  ROLE_EMPLOYEE,
}

class User extends Equatable {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  late Gender? gender;
  late DateTime? birthDate;
  late String? phoneNumber;
  late List<Address>? address;
  final List<Role> roles;

  @override
  List<Object> get props => [firstName, lastName, email, password];

  User({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.gender,
    this.birthDate,
    this.phoneNumber,
    this.address,
    this.roles = const [Role.ROLE_USER],
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
        ' address: $address,' +
        ' roles: $roles,' +
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
    List<Address>? address,
    List<Role>? roles,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
      'gender': this.gender,
      'birthDate': this.birthDate,
      'phoneNumber': this.phoneNumber,
      'address': this.address,
      'roles': this.roles,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      gender: map['gender'] as Gender,
      birthDate: map['birthDate'] as DateTime,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as List<Address>,
      roles: map['roles'] as List<Role>,
    );
  }
}