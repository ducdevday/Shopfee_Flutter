import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  final AuthRepository authRepository;

  PasswordCubit({required this.authRepository}) : super(PasswordInitial());

  void initPassword() {
    emit(const PasswordLoaded());
  }

  void enterOldPassword(String oldPassword) {
    if (state is PasswordLoaded) {
      final currentState = state as PasswordLoaded;
      emit(currentState.copyWith(oldPassword: oldPassword));
    }
  }

  void enterNewPassword(String newPassword) {
    if (state is PasswordLoaded) {
      final currentState = state as PasswordLoaded;
      emit(currentState.copyWith(newPassword: newPassword));
    }
  }

  void enterConfirmPassword(String confirmPassword) {
    if (state is PasswordLoaded) {
      final currentState = state as PasswordLoaded;
      emit(currentState.copyWith(confirmPassword: confirmPassword));
    }
  }

  Future<void> changePassword() async {
    if (state is PasswordLoaded) {
      try {
        final currentState = state as PasswordLoaded;
        if (currentState.newPassword != currentState.confirmPassword) {
          EasyLoading.showError(
              "New Password and Confirm New Password is not match");
          return;
        }
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await authRepository.changePasswordInAccount(
            currentState.oldPassword, currentState.newPassword);
        EasyLoading.dismiss();
        if (response.success) {
          EasyLoading.showSuccess("Change Password Successfully",
              duration: Duration(milliseconds: 1000));
          Future.delayed(Duration(milliseconds: 1000), () {
            emit(PasswordFinished());
          });
        } else {
          EasyLoading.showError("Current Password Incorrect",
              duration: Duration(milliseconds: 1000));
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
