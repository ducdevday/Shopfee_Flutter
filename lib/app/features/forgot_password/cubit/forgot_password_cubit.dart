import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;

  ForgotPasswordCubit({required this.authRepository})
      : super(ForgotPasswordInitial());

  Future<void> initCubit() async {
    emit(ForgotPasswordLoaded());
  }

  Future<void> addEmail(String email) async {
    if (state is ForgotPasswordLoaded) {
      emit(ForgotPasswordLoaded(email: email));
    }
  }

  Future<void> sendOTP(BuildContext context) async {
    if (state is ForgotPasswordLoaded) {
      final currentState = state as ForgotPasswordLoaded;
      try {
        if (currentState.errorString() != "") {
          throw (currentState.errorString());
        }
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response =
            await authRepository.passwordSendCode(currentState.email);
        EasyLoading.dismiss();
        if (response.success) {
          Navigator.pushNamed(context, "/otp", arguments: {
            "routeName": "/change_password",
            "email": currentState.email
          });
        } else {
          EasyLoading.showError('Something went wrong');
        }
      } catch (e) {
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    }
  }
}
