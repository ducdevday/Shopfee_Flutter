part of register;

class RegisterPage extends StatefulWidget {
  static const String route = "/register";

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPage> {
  late final TextEditingController firstNameTextController;
  late final TextEditingController lastNameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  late final RegisterCubit _cubit;

  @override
  void initState() {
    super.initState();
    firstNameTextController = TextEditingController();
    lastNameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    _cubit = ServiceLocator.sl<RegisterCubit>();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    //Todo: Check All Field validator
    _cubit.checkValidField(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        email: emailTextController.text,
        password: passwordTextController.text);
    if (type == FieldType.firstName && !ValidateFieldUtil.validateName(text)) {
      return "First name is not valid";
    } else if (type == FieldType.lastName &&
        !ValidateFieldUtil.validateName(text)) {
      return "Last name is not valid";
    } else if (type == FieldType.email &&
        !ValidateFieldUtil.validateEmail(text)) {
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
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFinished) {
              Navigator.of(context).pushNamed(OtpPage.route, arguments: {
                "email": emailTextController.text,
                "registerEntity": RegisterEntity(
                    firstName: firstNameTextController.text,
                    lastName: lastNameTextController.text,
                    email: emailTextController.text,
                    password: passwordTextController.text),
                "fromRoute": RegisterPage.route
              });
            }
          },
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: NameInputField(
                              title: "First Name",
                              hint: "Input Your First Name",
                              validateField: (String value) =>
                                  getErrorText(value, FieldType.firstName),
                              controller: firstNameTextController,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: NameInputField(
                              title: "Last Name",
                              hint: "Input Your Last Name",
                              validateField: (String value) =>
                                  getErrorText(value, FieldType.lastName),
                              controller: lastNameTextController,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      EmailInputField(
                        title: "Email",
                        hint: "Input Your Email",
                        validateField: (String value) =>
                            getErrorText(value, FieldType.email),
                        controller: emailTextController,
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
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // Text(
                      //   "By tapping \"Register\" you agree to our",
                      //   style: AppStyle.normalTextStyleDark,
                      // ),
                      // const SizedBox(
                      //   height: 4,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     TextButton(
                      //         style: TextButton.styleFrom(
                      //           minimumSize: Size.zero,
                      //           padding: EdgeInsets.zero,
                      //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //         ),
                      //         onPressed: () {},
                      //         child: Text(
                      //           "Terms of Use",
                      //           style: AppStyle.normalTextStyleDark
                      //               .copyWith(color: const Color(0xff032172)),
                      //         )),
                      //     TextButton(
                      //         style: TextButton.styleFrom(
                      //           minimumSize: Size.zero,
                      //           padding: EdgeInsets.zero,
                      //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //         ),
                      //         onPressed: () {},
                      //         child: Text(
                      //           " and ",
                      //           style: AppStyle.normalTextStyleDark,
                      //         )),
                      //     TextButton(
                      //         style: TextButton.styleFrom(
                      //           minimumSize: Size.zero,
                      //           padding: EdgeInsets.zero,
                      //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      //         ),
                      //         onPressed: () {},
                      //         child: Text(
                      //           "Privacy Policy",
                      //           style: AppStyle.normalTextStyleDark
                      //               .copyWith(color: const Color(0xff032172)),
                      //         ))
                      //   ],
                      // ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is! RegisterInitial
                                  ? () {
                                      _cubit.goToOTPPage(
                                          firstName:
                                              firstNameTextController.text,
                                          lastName: lastNameTextController.text,
                                          email: emailTextController.text,
                                          password:
                                              passwordTextController.text);
                                    }
                                  : null,
                              child: const Text("Register"),
                              style: ElevatedButton.styleFrom(
                                  disabledBackgroundColor:
                                      const Color(0xffCACACA),
                                  disabledForegroundColor: AppColor.lightColor,
                                  textStyle: AppStyle.mediumTextStyleDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Have an account? ",
                                style: AppStyle.normalTextStyleDark,
                              )),
                          TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Login",
                                style: AppStyle.normalTextStylePrimary,
                              ))
                        ],
                      ),
                      Text(
                        "or ",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            NavigationUtil.pushNamed(DefaultPage.route);
                          },
                          child: Text(
                            "Continue as guess",
                            style: AppStyle.normalTextStylePrimary,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
