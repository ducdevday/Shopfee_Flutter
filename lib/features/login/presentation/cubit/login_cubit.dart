part of login;

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  bool checkValidField({required String email, required String password}) {
    if (ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePassword(password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> doLogin(String email, String password) async {
    if (checkValidField(email: email, password: password) == false) return;
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final emailExist = await _loginUseCase.checkEmailExist(email);
      if (!emailExist) {
        EasyLoading.showInfo("Email does not exist");
        return;
      }
      final response = await _loginUseCase.login(LoginEntity(
          email: email,
          password: password,
          fcmTokenId: SharedService.getFCMTokenId()!));
      SharedService.setToken(response.userId, response.accessToken);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Login Success");
      NavigationUtil.pushNamedAndRemoveUntil(DefaultPage.route);
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  Future<void> doLoginGoogle() async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      final response =
          await _loginUseCase.loginWithGoogle(SharedService.getFCMTokenId()!);
      SharedService.setToken(response.userId, response.accessToken);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Login Success");
      NavigationUtil.pushNamedAndRemoveUntil(DefaultPage.route);
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
