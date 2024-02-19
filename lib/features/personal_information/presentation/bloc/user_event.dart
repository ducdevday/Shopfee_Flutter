part of personal_infomation;

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
