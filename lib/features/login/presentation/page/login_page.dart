part of login;

class LoginPage extends StatefulWidget {
  static const String route = "/login";
  final String? fromRoute;

  const LoginPage({Key? key, this.fromRoute}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginCubit _cubit;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    _cubit = ServiceLocator.sl<LoginCubit>();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    _cubit.close();
    super.dispose();
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    if (type == FieldType.email && !ValidateFieldUtil.validateEmail(text)) {
      return R.emailCheck.tr();
    } else if (type == FieldType.password &&
        !ValidateFieldUtil.validatePassword(text)) {
      return R.passwordCheck.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(AppDimen.screenPadding),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Builder(builder: (_) {
                            if (widget.fromRoute != null &&
                                widget.fromRoute == DefaultPage.route) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    margin: const EdgeInsets.only(top: 16),
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColor.disableColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      iconSize: 16,
                                      onPressed: () {
                                        NavigationUtil.pop();
                                      },
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.white,
                                      ),
                                    )),
                              );
                            }
                            return const SizedBox();
                          }),
                          const SizedBox(
                            height: 150,
                          ),
                        ],
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
                        R.welcomeBack.tr(),
                        style: AppStyle.superLargeTitleStylePrimary,
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      EmailInputField(
                        title: "Email",
                        hint: R.inputEmail.tr(),
                        validateField: (String value) =>
                            getErrorText(value, FieldType.email),
                        controller: emailTextController,
                        useFocus: false,
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      PasswordInputField(
                        title: R.password.tr(),
                        hint: R.inputPassword.tr(),
                        validateField: (String value) =>
                            getErrorText(value, FieldType.password),
                        controller: passwordTextController,
                        useFocus: false,
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                NavigationUtil
                                    .pushNamed(ForgotPasswordPage.route);
                              },
                              child: Text(
                                R.youForgotPassword.tr(),
                                style: AppStyle.normalTextStylePrimary,
                              ))),
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                formKey.currentState?.validate();
                                _cubit.doLogin(emailTextController.text,
                                    passwordTextController.text);
                              },
                              child:  Text(R.login.tr()),
                              style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor:
                                      const Color(0xffCACACA),
                                  disabledForegroundColor:
                                      AppColor.lightColor,
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
                ),
                BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            height: 2,
                            thickness: 2,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            R.or.tr(),
                            style: AppStyle.normalTextStyleDark,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            height: 2,
                            thickness: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<LoginCubit>().doLoginGoogle();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Colors.white),
                        child: SvgPicture.asset(
                          AppPath.icGoogle,
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimen.spacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${R.newUser.tr()}? ",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              NavigationUtil
                                  .pushNamed(RegisterPage.route);
                            },
                            child: Text(
                             R.register.tr(),
                              style: AppStyle.normalTextStylePrimary,
                            ))
                      ],
                    ),
                  ]);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
