import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserRepository userRepository;
  final LocalRepository localRepository;
  final FirebaseRepository firebaseRepository;

  AccountBloc({
    required this.userRepository,
    required this.localRepository,
    required this.firebaseRepository,
  }) : super(AccountInitial()) {
    on<LoadAccount>(_onLoadAccount);
    on<LogoutAccount>(_onLogoutAccount);
    on<NavigateLogin>(_onNavigateLogin);
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

  FutureOr<void> _onLogoutAccount(
      LogoutAccount event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      EasyLoading.show();
      await firebaseRepository.deleteFCMToken(GlobalData.ins.userId!);
      await firebaseRepository.logoutWithGoogle();
      await localRepository.deleteUser();
      EasyLoading.dismiss();
      add(LoadAccount());
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> _onNavigateLogin(
      NavigateLogin event, Emitter<AccountState> emit) {
    emit(AccountNavigateLogin());
    add(LoadAccount());
  }
}
