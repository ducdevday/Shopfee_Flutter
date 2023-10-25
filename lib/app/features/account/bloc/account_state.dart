part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountLoaded extends AccountState {
  final User user;

  const AccountLoaded({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}

class AccountNoAuth extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountNavigateLogin extends AccountState{
  @override
  List<Object?> get props => [];
}
