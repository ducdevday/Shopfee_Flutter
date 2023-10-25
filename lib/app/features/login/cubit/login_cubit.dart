import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;
  final FirebaseRepository firebaseRepository;
  final UserRepository userRepository;
  final LocalRepository localRepository;
  LoginCubit({required this.authRepository,
    required this.firebaseRepository,
    required this.userRepository,
    required this.localRepository, }) : super(LoginInitial());

  Future<void> initField() async {
    emit(LoginLoaded());
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
          await localRepository.saveUser(response.data!["userId"], response.data!["accessToken"], response.data!["refreshToken"]);

          Navigator.pushNamedAndRemoveUntil(
              context, "/home", (route) => false);
        } else {
          EasyLoading.showError('Invalid Email or Password');
        }
      } catch (e) {
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
        print(userId);
        print(email);
        print(displayName);

        var responseCheckEmail = await userRepository.checkEmailExist(email);
        if (responseCheckEmail.success) {
          await doLoginGG(context, email: email, password: userId);
        }
        else {
          final fullname = displayName.split(" ").toList();
          String firstName = fullname.elementAt(0);
          String lastName = fullname.elementAt(fullname.length - 1);
          await doRegisterGG(context, email: email,firstName: firstName, lastName: lastName, password:userId );
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
      var response = await authRepository.login(
          email, password);
      EasyLoading.dismiss();
      if (response.success) {
        await localRepository.saveUser(
            response.data!["userId"], response.data!["accessToken"],
            response.data!["refreshToken"]);

        Navigator.pushNamedAndRemoveUntil(
            context, "/home", (route) => false);
      } else {
        EasyLoading.showError('Invalid Email or Password');
      }
    } catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }

  Future<void> doRegisterGG(BuildContext context,
      {required String firstName, required String lastName, required String email, required String password}) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await authRepository.register(User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password));
      EasyLoading.dismiss();
      if (response.success) {
        await localRepository.saveUser(
            response.data!["userId"], response.data!["accessToken"],
            response.data!["refreshToken"]);
        Navigator.pushNamedAndRemoveUntil(
            context, "/home", (route) => false);
      } else {
        EasyLoading.showError('Something went wrong');
      }
    } catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }
}

