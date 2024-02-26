part of new_password;

abstract class NewPasswordState extends Equatable {
  const NewPasswordState();
}

class NewPasswordInitial extends NewPasswordState {
  @override
  List<Object> get props => [];
}

class NewPasswordSuccess extends NewPasswordState {
  @override
  List<Object> get props => [];
}
