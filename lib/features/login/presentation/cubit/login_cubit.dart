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
      final response = await _loginUseCase
          .login(LoginEntity(email: email, password: password));
      SharedService.setToken(
          response.userId, response.accessToken);
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Login Success");
      emit(LoginSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  Future<void> doLoginGoogle() async {
    try {
      final response = await _loginUseCase.loginWithGoogle();
      SharedService.setToken(
          response.userId, response.accessToken);
      EasyLoading.showSuccess("Login Success");
      emit(LoginSuccess());
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}

// Future<void> loginWithGoogle(BuildContext context) async {
//   if (state is LoginLoaded) {
//     try {
//       await firebaseRepository.logInWithGoogle();
//       Result result = await firebaseRepository.getGoogleUser();
//       Map<String, dynamic>? data = result.data;
//       // ! Khi sử dụng login by google, Google userId được sử dụng làm password để đăng nhập/ đăng ký
//       String userId = data!["id"];
//       String email = data["email"];
//       String displayName = data["displayName"];
//       var responseCheckEmail = await userRepository.checkEmailExist(email);
//
//       if (responseCheckEmail.success) {
//         await doLoginGG(context, email: email, password: userId);
//       } else {
//         final fullname = displayName.split(" ").toList();
//         String firstName = fullname.elementAt(0);
//         String lastName = fullname.elementAt(fullname.length - 1);
//         await doRegisterGG(context,
//             email: email,
//             firstName: firstName,
//             lastName: lastName,
//             password: userId);
//       }
//     } catch (e) {
//       print(e.toString());
//       EasyLoading.showError(e.toString());
//     }
//   }
// }
//
// Future<void> doLoginGG(BuildContext context,
//     {required String email, required String password}) async {
//   try {
//     EasyLoading.show(maskType: EasyLoadingMaskType.black);
//     var response = await authRepository.login(email, password);
//     EasyLoading.dismiss();
//     if (response.success) {
//       await doSaveUserAndGoHome(
//           userId: response.data!["userId"],
//           accessToken: response.data!["accessToken"],
//           refreshToken: response.data!["refreshToken"],
//           context: context);
//     } else {
//       EasyLoading.showError('Invalid Email or Password');
//     }
//   } catch (e) {
//     print(e);
//     EasyLoading.showToast(e.toString());
//   }
// }
//
// Future<void> doRegisterGG(BuildContext context,
//     {required String firstName,
//       required String lastName,
//       required String email,
//       required String password}) async {
//   try {
//     EasyLoading.show(maskType: EasyLoadingMaskType.black);
//     var response = await authRepository.register(User(
//         firstName: firstName,
//         lastName: lastName,
//         email: email,
//         password: password));
//     EasyLoading.dismiss();
//     if (response.success) {
//       await doSaveUserAndGoHome(
//           userId: response.data!["userId"],
//           accessToken: response.data!["accessToken"],
//           refreshToken: response.data!["refreshToken"],
//           context: context);
//     } else {
//       EasyLoading.showError('Something went wrong');
//     }
//   } catch (e) {
//     print(e);
//     EasyLoading.showToast(e.toString());
//   }
// }
//
// Future<void> doSaveUserAndGoHome({required String userId,
//   required String accessToken,
//   required String refreshToken,
//   required BuildContext context}) async {
//   await localRepository.saveUser(userId, accessToken, refreshToken);
//   await firebaseRepository.saveFCMToken(userId);
//
//   context
//       .read<HistoryBloc>()
//       .add(const LoadHistory(historyStatus: HistoryStatus.Processing));
//   context.read<AccountBloc>().add(LoadAccount());
//   context.read<MyBottomNavigationBarCubit>().selectPage(0);
//
//   Navigator.pushNamedAndRemoveUntil(
//       context, AppRouter.homeRoute, (route) => false);
// }
