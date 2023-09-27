part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoaded extends LoginState {
  final String email;
  final String password;

  const LoginLoaded({this.email = "", this.password = ""});

  bool isValid() {
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginState{email: $email, password: $password}';
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

  factory LoginLoaded.fromMap(Map<String, dynamic> map) {
    return LoginLoaded(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}
