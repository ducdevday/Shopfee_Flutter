import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/features/account/bloc/account_bloc.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/no_network/no_network_page.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

import '../../history/bloc/history_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final FirebaseRepository firebaseRepository;
  final UserRepository userRepository;
  final LocalRepository localRepository;

  LoginCubit({
    required this.authRepository,
    required this.firebaseRepository,
    required this.userRepository,
    required this.localRepository,
  }) : super(LoginInitial());

  Future<void> initField() async {
    emit(const LoginLoaded());
  }

  Future<void> addField(String field, String value) async {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      if (field == 'Email') {
        emit(LoginLoaded(email: value, password: currentState.password));
      } else if (field == 'Password') {
        emit(LoginLoaded(email: currentState.email, password: value));
      }
    }
  }

  Future<void> doLogin(BuildContext context) async {
    if (state is LoginLoaded) {
      final currentState = state as LoginLoaded;
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await authRepository.login(
            currentState.email, currentState.password);
        EasyLoading.dismiss();
        if (response.success) {
          await doSaveUserAndGoHome(
              userId: response.data!["userId"],
              accessToken: response.data!["accessToken"],
              refreshToken: response.data!["refreshToken"],
              context: context);
        } else {
          EasyLoading.showError('Incorrect Email or Password');
        }
      } catch (e) {
        if (e is DioException) {
          if (e.type == DioExceptionType.connectionError) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoNetWorkPage()));
          } else if (e.response?.statusCode == 401) {
            return EasyLoading.showError("Password is incorrect",
                duration: Duration(seconds: 1));
          } else if (e.response?.statusCode == 404) {
            return EasyLoading.showError("Account doesn't exist",
                duration: Duration(seconds: 1));
          }
        }
        print(e);
        EasyLoading.showToast(e.toString());
      }
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    if (state is LoginLoaded) {
      try {
        await firebaseRepository.logInWithGoogle();
        Result result = await firebaseRepository.getGoogleUser();
        Map<String, dynamic>? data = result.data;
        // ! Khi sử dụng login by google, Google userId được sử dụng làm password để đăng nhập/ đăng ký
        String userId = data!["id"];
        String email = data["email"];
        String displayName = data["displayName"];
        var responseCheckEmail = await userRepository.checkEmailExist(email);

        if (responseCheckEmail.success) {
          await doLoginGG(context, email: email, password: userId);
        } else {
          final fullname = displayName.split(" ").toList();
          String firstName = fullname.elementAt(0);
          String lastName = fullname.elementAt(fullname.length - 1);
          await doRegisterGG(context,
              email: email,
              firstName: firstName,
              lastName: lastName,
              password: userId);
        }
      } catch (e) {
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    }
  }

  Future<void> doLoginGG(BuildContext context,
      {required String email, required String password}) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await authRepository.login(email, password);
      EasyLoading.dismiss();
      if (response.success) {
        await doSaveUserAndGoHome(
            userId: response.data!["userId"],
            accessToken: response.data!["accessToken"],
            refreshToken: response.data!["refreshToken"],
            context: context);
      } else {
        EasyLoading.showError('Invalid Email or Password');
      }
    } catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }

  Future<void> doRegisterGG(BuildContext context,
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await authRepository.register(User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password));
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

  Future<void> doSaveUserAndGoHome(
      {required String userId,
      required String accessToken,
      required String refreshToken,
      required BuildContext context}) async {


    await localRepository.saveUser(userId, accessToken, refreshToken);
    await firebaseRepository.saveFCMToken(userId);

    context
        .read<HistoryBloc>()
        .add(const LoadHistory(historyStatus: HistoryStatus.Processing));
    context.read<AccountBloc>().add(LoadAccount());

    Navigator.pushNamedAndRemoveUntil(context,AppRouter.homeRoute, (route) => false);
  }


}
