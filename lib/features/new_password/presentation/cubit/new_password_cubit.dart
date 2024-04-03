part of new_password;

class NewPasswordCubit extends Cubit<NewPasswordState> {
  final NewPasswordUseCase _newPasswordUseCase;

  NewPasswordCubit(this._newPasswordUseCase) : super(NewPasswordInitial());

  bool checkValidField({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (ValidateFieldUtil.validatePassword(currentPassword) &&
        ValidateFieldUtil.validatePassword(newPassword) &&
        ValidateFieldUtil.validatePassword(confirmPassword) &&
        newPassword == confirmPassword) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> changePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    if (checkValidField(
            currentPassword: currentPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword) ==
        false) return;
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await _newPasswordUseCase.changePassword(NewPasswordEntity(
          userId: SharedService.getUserId()!,
          oldPassword: currentPassword,
          newPassword: newPassword));
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Change Password Successfully",
          duration: Duration(milliseconds: 1000));
      emit(NewPasswordSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
