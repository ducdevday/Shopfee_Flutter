part of 'welcome_cubit.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
}

class WelcomeInitial extends WelcomeState {
  @override
  List<Object> get props => [];
}

class WelcomeLoaded extends WelcomeState {
  final String email;
  const WelcomeLoaded({
    this.email ="",
  });
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
    return 'WelcomeLoaded{' + ' email: $email,' + '}';
  }

  WelcomeLoaded copyWith({
    String? email,
  }) {
    return WelcomeLoaded(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
    };
  }

  factory WelcomeLoaded.fromMap(Map<String, dynamic> map) {
    return WelcomeLoaded(
      email: map['email'] as String,
    );
  }
}
