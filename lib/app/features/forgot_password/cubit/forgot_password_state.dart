part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoaded extends ForgotPasswordState {
  final String email;

  const ForgotPasswordLoaded({this.email = ""});

  bool isValid() {
    if (email.isEmpty) {
      return false;
    }
    return true;
  }
  String errorString(){
    if (email.isEmpty) {
      return "Please fill this field";
    }
    else if(EmailValidator.validate(email) == false){
      return "Invalid email";
    }
    return "";
  }

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'ForgotPasswordLoaded{' + ' email: $email,' + '}';
  }

  ForgotPasswordLoaded copyWith({
    String? email,
  }) {
    return ForgotPasswordLoaded(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
    };
  }

  factory ForgotPasswordLoaded.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordLoaded(
      email: map['email'] as String,
    );
  }
}
