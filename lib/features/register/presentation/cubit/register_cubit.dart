part of register;

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  void checkValidField({required String firstName,
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

  void goToOTPPage({required String firstName,
    required String lastName,
    required String email,
    required String password}) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final emailExist = await _registerUseCase.checkEmailExist(email);
      await Future.delayed(Duration(seconds: 1));
      EasyLoading.dismiss();
      if (emailExist) {
        EasyLoading.showInfo("Email is exist");
      } else {
        emit(RegisterFinished(
            registerEntity: RegisterEntity(
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password)));
      }
    }
    catch(e){

    }
  }
}
