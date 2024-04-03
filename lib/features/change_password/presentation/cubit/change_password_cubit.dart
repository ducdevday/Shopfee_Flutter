part of change_password;

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
      : super(ChangePasswordInitial());

  void checkValidField(
      {required String password, required String confirmPassword}) {
    if (ValidateFieldUtil.validatePassword(password) &&
        ValidateFieldUtil.validatePassword(confirmPassword) &&
        password == confirmPassword) {
      emit(ChangePasswordReady());
    } else {
      emit(ChangePasswordInitial());
    }
  }

  Future<void> changePassword(String email, String password, String code) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response = await _changePasswordUseCase.changePassword(
          ChangePasswordEntity(email: email, password: password,code: code));
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Change Password Success");
      emit(ChangePasswordSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
