part of user;

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoadInformation extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserLogout extends UserEvent {
  @override
  List<Object> get props => [];
}
