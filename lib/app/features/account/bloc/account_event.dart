part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class LoadAccount extends AccountEvent {

  const LoadAccount();

  @override
  List<Object> get props => [];

}

class LogoutAccount extends AccountEvent {
  @override
  List<Object> get props => [];
}

class NavigateLogin extends AccountEvent {
  @override
  List<Object> get props => [];
}