part of change_password;

class ChangePasswordPage extends StatefulWidget {
  static const String route = "/change_password";
  final String email;
  final String code;

  const ChangePasswordPage({Key? key, required this.email, required this.code}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final ChangePasswordCubit _cubit;
  late final TextEditingController passwordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<ChangePasswordCubit>();
    passwordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _cubit.close();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  String? getErrorText(String text,
      FieldType type,) {
    _cubit.checkValidField(
        password: passwordTextController.text,
        confirmPassword: confirmPasswordTextController.text);
    if (type == FieldType.password &&
        !ValidateFieldUtil.validatePassword(text)) {
      return "Password must have greater or equal 6 digits";
    } else if (type == FieldType.confirmPassword &&
        !ValidateFieldUtil.validatePassword(text)) {
      return "Password must have greater or equal 6 digits";
    } else if (type == FieldType.confirmPassword &&
        passwordTextController.text != confirmPasswordTextController.text) {
      return "Password and confirm password not match";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if(state is ChangePasswordSuccess){
            NavigationUtil.pushNamedAndRemoveUntil(LoginPage.route);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: const EdgeInsets.all(AppDimen.screenPadding),
            child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    Image.asset(
                      AppPath.imgLogo2,
                      width: 219.5,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Update Your Password",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    PasswordInputField(
                      title: "Password",
                      hint: "Input Your Password",
                      validateField: (String value) =>
                          getErrorText(value, FieldType.password),
                      controller: passwordTextController,
                    ),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    PasswordInputField(
                      title: "Confirm Password",
                      hint: "Input Your Confirm Password",
                      validateField: (String value) =>
                          getErrorText(value, FieldType.confirmPassword),
                      controller: confirmPasswordTextController,
                    ),
                    const SizedBox(height: AppDimen.spacing),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "*Password must have greater or equal 6 characters",
                          style: AppStyle.smallTextStyleDark,
                        )),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child:
                      BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state is! ChangePasswordInitial
                                ? () {
                              _cubit.changePassword(
                                  widget.email, passwordTextController.text, widget.code);
                            }
                                : null,
                            child: const Text("Change Password"),
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: const Color(
                                    0xffCACACA),
                                disabledForegroundColor: AppColor.lightColor,
                                textStyle: AppStyle.mediumTextStyleDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
