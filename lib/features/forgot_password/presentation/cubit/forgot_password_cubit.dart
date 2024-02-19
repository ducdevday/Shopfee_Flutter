part of forgot_password;

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit()
      : super(ForgotPasswordInitial());

  void checkValidField({required String email}){
    if(ValidateFieldUtil.validateEmail(email)){
      emit(ForgotPasswordReady());
    }
    else{
      emit(ForgotPasswordInitial());
    }
  }

  Future<void> goToOtpPage() async {
    emit(ForgotPasswordFinished());
  }
}
