part of register;

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  void checkValidField({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (ValidateFieldUtil.validateName(firstName) &&
        ValidateFieldUtil.validateName(lastName) &&
        ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePassword(password) &&
        ValidateFieldUtil.validatePassword(confirmPassword) &&
        password == confirmPassword) {
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
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final emailExist = await _registerUseCase.checkEmailExist(email);
      await Future.delayed(Duration(seconds: 1));
      EasyLoading.dismiss();
      if (emailExist) {
        EasyLoading.showInfo("Email already exists");
      } else {
        emit(RegisterFinished(
            registerEntity: RegisterEntity(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                fcmTokenId: SharedService.getFCMTokenId()!)));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
