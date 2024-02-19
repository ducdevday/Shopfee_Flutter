part of change_password;

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(this._changePasswordUseCase)
      : super(ChangePasswordInitial());

  void checkValidField(
      {
      required String password,
      required String confirmPassword}) {
    if (
        ValidateFieldUtil.validatePassword(password) &&
        ValidateFieldUtil.validatePassword(confirmPassword) &&
        password == confirmPassword) {
      emit(ChangePasswordReady());
    } else {
      emit(ChangePasswordInitial());
    }
  }

  Future<void> changePassword(String email, String password) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response = await _changePasswordUseCase.changePassword(
          ChangePasswordEntity(email: email, password: password));
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Change Password Success");
      emit(ChangePasswordSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

// Future<void> changePassword(BuildContext context, String email) async {
//   if (state is ChangePasswordLoaded) {
//     final currentState = state as ChangePasswordLoaded;
//     try {
//       if (currentState.errorString() != "") {
//         throw (currentState.errorString());
//       }
//       EasyLoading.show(maskType: EasyLoadingMaskType.black);
//       var response = await authRepository.changePassword(
//           email, currentState.newPassword);
//       EasyLoading.dismiss();
//       if (response.success) {
//         EasyLoading.showSuccess("Change Password Success",
//             duration: Duration(milliseconds: 1000));
//         Future.delayed(Duration(milliseconds: 1000), () {
//           emit(ChangePasswordSuccess());
//         });
//       } else {
//         EasyLoading.showError('Something went wrong');
//       }
//     } catch (e) {
//       print(e);
//       EasyLoading.showError(e.toString());
//
//     }
//   }
// }
}
