part of forgot_password;

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordCubit(this._forgotPasswordUseCase)
      : super(ForgotPasswordInitial());

  void checkValidField({required String email}) {
    if (ValidateFieldUtil.validateEmail(email)) {
      emit(ForgotPasswordReady());
    } else {
      emit(ForgotPasswordInitial());
    }
  }

  Future<void> goToOtpPage(String email) async {
    try {
      final emailExist = await _forgotPasswordUseCase.checkEmailExist(email);
      if (emailExist) {
        emit(ForgotPasswordFinished());
      } else {
        EasyLoading.showError("Email is not exist");
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
