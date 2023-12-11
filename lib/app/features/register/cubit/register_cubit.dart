import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/features/account/bloc/account_bloc.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;
  final LocalRepository localRepository;
  final FirebaseRepository firebaseRepository;

  RegisterCubit(
      {required this.authRepository,
      required this.localRepository,
      required this.firebaseRepository})
      : super(RegisterInitial());

  Future<void> initField(String email) async {
    emit(RegisterLoaded(email: email));
  }

  Future<void> addField(String field, String value) async {
    if (state is RegisterLoaded) {
      final currentState = state as RegisterLoaded;
      if (field == 'First Name') {
        emit(RegisterLoaded(
            firstName: value,
            lastName: currentState.lastName,
            email: currentState.email,
            password: currentState.password));
      } else if (field == 'Last Name') {
        emit(RegisterLoaded(
            firstName: currentState.firstName,
            lastName: value,
            email: currentState.email,
            password: currentState.password));
      } else if (field == 'Email') {
        emit(RegisterLoaded(
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: value,
            password: currentState.password));
      } else if (field == 'Password') {
        emit(RegisterLoaded(
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: currentState.email,
            password: value));
      }
    }
  }

  Future<void> doRegister(BuildContext context) async {
    if (state is RegisterLoaded) {
      final currentState = state as RegisterLoaded;
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await authRepository.register(User(
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: currentState.email,
            password: currentState.password));
        EasyLoading.dismiss();
        if (response.success) {
          await doSaveUserAndGoHome(
              userId: response.data!["userId"],
              accessToken: response.data!["accessToken"],
              refreshToken: response.data!["refreshToken"],
              context: context);
        } else {
          EasyLoading.showError('Something went wrong');
        }
      } catch (e) {
        print(e);
        EasyLoading.showToast(e.toString());
      }
    }
  }

  Future<void> doSaveUserAndGoHome(
      {required String userId,
      required String accessToken,
      required String refreshToken,
      required BuildContext context}) async {
    try {
      await localRepository.saveUser(userId, accessToken, refreshToken);
      await firebaseRepository.saveFCMToken(userId);

      context
          .read<HistoryBloc>()
          .add(LoadHistory(historyStatus: HistoryStatus.Processing));
      context.read<AccountBloc>().add(LoadAccount());

      Navigator.pushNamedAndRemoveUntil(
          context, AppRouter.homeRoute, (route) => false);
    } catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }
}
