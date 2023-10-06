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
    this.email = "",
  });

  bool isValid() {
    if (email.isEmpty) {
      return false;
    }
    return true;
  }

  String errorString() {
    if (email.isEmpty) {
      return "Please fill this field";
    }
    else if (EmailValidator.validate(email) == false) {
      return "Invalid email";
    }
    return "";
  }

  @override
  List<Object> get props => [email];


}

class WelcomeExistEmail extends WelcomeState {
  final String email;
  const WelcomeExistEmail({
    required this.email,
  });
  @override
  List<Object> get props => [];
}
