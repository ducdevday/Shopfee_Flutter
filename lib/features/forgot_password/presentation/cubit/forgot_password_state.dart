part of forgot_password;

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordReady extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordFinished extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
