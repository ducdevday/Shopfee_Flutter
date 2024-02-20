import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void checkValidField(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) {
    if (ValidateFieldUtil.validateName(firstName) &&
        ValidateFieldUtil.validateName(lastName) &&
        ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePassword(password)) {
      print("RegisterCubit RegisterReady🚩🚩🚩");
      emit(RegisterReady());
    } else {
      print("RegisterCubit Not Ready🚩🚩🚩");
      emit(RegisterInitial());
    }
  }

  void goToOTPPage(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    // EasyLoading.show();
    // await Future.delayed(Duration(seconds: 1));
    // EasyLoading.dismiss();
    emit(RegisterFinished(
        registerEntity: RegisterEntity(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password)));
  }
}
