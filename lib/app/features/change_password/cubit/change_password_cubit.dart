import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final AuthRepository authRepository;

  ChangePasswordCubit({required this.authRepository})
      : super(ChangePasswordInitial());

  void initField() {
    emit(ChangePasswordLoaded());
  }

  Future<void> addField(String field, String value) async {
    if (state is ChangePasswordLoaded) {
      final currentState = state as ChangePasswordLoaded;
      if (field == 'New Password') {
        emit(currentState.copyWith(newPassword: value));
      } else if (field == 'Confirm Password') {
        emit(currentState.copyWith(confirmPassword: value));
      }
    }
  }

  Future<void> changePassword(BuildContext context, String email) async {
    if (state is ChangePasswordLoaded) {
      final currentState = state as ChangePasswordLoaded;
      try {
        if (currentState.errorString() != "") {
          throw (currentState.errorString());
        }
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await authRepository.changePassword(
            email, currentState.newPassword);
        EasyLoading.dismiss();
        if (response.success) {
          EasyLoading.showSuccess("Change Password Success",
              duration: Duration(milliseconds: 1000));
          Future.delayed(Duration(milliseconds: 1000), () {
            emit(ChangePasswordSuccess());
          });
        } else {
          EasyLoading.showError('Something went wrong');
        }
      } catch (e) {
        print(e);
        EasyLoading.showError(e.toString());

      }
    }
  }
}
