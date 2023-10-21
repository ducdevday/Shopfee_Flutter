import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;

  AccountBloc({required this.userRepository}) : super(AccountInitial()) {
    on<LoadAccount>(_onLoadAccount);
  }

  FutureOr<void> _onLoadAccount(
      LoadAccount event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    if (GlobalData.ins.userId == null) {
      emit(AccountNoAuth());
      return;
    }
    try {
      var response = await userRepository.getUser(GlobalData.ins.userId!);
      if (response.success) {
        final User user = User.fromJson(response.data!);
        emit(AccountLoaded(user: user));
      }
    } catch (e) {
      print(e);
    }
  }
}
