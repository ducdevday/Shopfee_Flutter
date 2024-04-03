part of change_password;

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordReady extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  @override
  List<Object?> get props => [];

}