part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class LoadAccount extends AccountEvent {

  const LoadAccount();

  @override
  List<Object> get props => [];

}