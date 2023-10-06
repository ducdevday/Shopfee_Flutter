import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;

  RegisterCubit({required this.authRepository}) : super(RegisterInitial());

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
        EasyLoading.show(
            status: 'Registering...', maskType: EasyLoadingMaskType.black);
        var response = await authRepository.register(User(
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: currentState.email,
            password: currentState.password));
        EasyLoading.dismiss();
        if (response.success) {
          print("doRegister Success");

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', response.data!["id"]);
          await prefs.setString('accessToken', response.data!["accessToken"]);
          Navigator.pushNamed(context, "/home");

        } else {
          EasyLoading.showError('Something went wrong');
        }
      } catch (e) {
        print(e);
        EasyLoading.showToast(e.toString());
      }
    }
  }
}
