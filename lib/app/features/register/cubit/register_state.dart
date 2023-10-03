part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState{
  @override
  List<Object?> get props => [];

}

class RegisterLoaded extends RegisterState {
   final String firstName;
   final String lastName;
   final String email;
   final String password;

  RegisterLoaded(
      {this.firstName = "",
      this.lastName = "",
      this.email = "",
      this.password = ""});

  bool isValid() {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  List<Object> get props => [firstName, lastName, email, password];

  @override
  String toString() {
    return 'RegisterState{firstName: $firstName, lastName: $lastName, email: $email, password: $password}';
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
    };
  }

  factory RegisterLoaded.fromMap(Map<String, dynamic> map) {
    return RegisterLoaded(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
