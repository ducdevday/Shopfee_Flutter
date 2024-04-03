part of user;

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadInProcess extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadSuccess extends UserState {
  final UserEntity user;

  const UserLoadSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];

  UserLoadSuccess copyWith({
    UserEntity? user,
  }) {
    return UserLoadSuccess(
      user: user ?? this.user,
    );
  }
}

class UserLoadFailure extends UserState {
  @override
  List<Object> get props => [];
}