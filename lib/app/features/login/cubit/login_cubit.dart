import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository}) : super(LoginInitial());

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
          print("doLogin Success");
          print(response.data);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', response.data!["userId"]);
          await prefs.setString('accessToken', response.data!["accessToken"]);
          GlobalData.ins.userId = prefs.getString('userId');
          GlobalData.ins.accessToken = prefs.getString('accessToken');

          Navigator.pushNamed(context, "/home");
        } else {
          EasyLoading.showError('Invalid Email or Password');
        }
      } catch (e) {
        print(e);
        EasyLoading.showToast(e.toString());
      }
    }
  }
}
