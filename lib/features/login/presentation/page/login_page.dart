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
      return "Email is not valid";
    } else if (type == FieldType.password &&
        !ValidateFieldUtil.validatePassword(text)) {
      return "Password must have greater or equal 6 digits";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(DefaultPage.route, (route) => false);
            }
          },
          child: SingleChildScrollView(
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
                            Builder(builder: (_){
                              if(widget.fromRoute != null && widget.fromRoute == DefaultPage.route){
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
                          "Welcome Back!",
                          style: AppStyle.superLargeTitleStylePrimary,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        EmailInputField(
                          title: "Email",
                          hint: "Input Your Email",
                          validateField: (String value) =>
                              getErrorText(value, FieldType.email),
                          controller: emailTextController,
                          useFocus: false,
                        ),
                        const SizedBox(
                          height: AppDimen.spacing,
                        ),
                        PasswordInputField(
                          title: "Password",
                          hint: "Input Your Password",
                          validateField: (String value) =>
                              getErrorText(value, FieldType.password),
                          controller: passwordTextController,
                          useFocus: false,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(ForgotPasswordPage.route);
                                },
                                child: Text(
                                  "Forgot password?",
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
                                child: const Text("Login"),
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
                              "or",
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
                            "New User? ",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(RegisterPage.route);
                              },
                              child: Text(
                                "Register",
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
      ),
    );
  }
}
