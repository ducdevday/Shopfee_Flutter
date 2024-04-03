part of user;

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserLoadInformation extends UserEvent {
  @override
  List<Object> get props => [];
}

class UserUpdateInformation extends UserEvent {
  final UserEntity user;

  @override
  List<Object> get props => [user];

  const UserUpdateInformation({
    required this.user,
  });
}

class UserUpdatePhoneNumber extends UserEvent {
  final String phoneNumber;

  const UserUpdatePhoneNumber({
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [phoneNumber];
}

class UserLogout extends UserEvent {
  @override
  List<Object> get props => [];
}
