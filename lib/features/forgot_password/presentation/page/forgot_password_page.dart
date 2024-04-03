part of forgot_password;

class ForgotPasswordPage extends StatefulWidget {
  static const String route = "/forgot_password";

  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final ForgotPasswordCubit _cubit;
  late final TextEditingController emailTextController;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<ForgotPasswordCubit>();
    emailTextController = TextEditingController();
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
    _cubit.checkValidField(
      email: emailTextController.text,
    );
    if (type == FieldType.email && !ValidateFieldUtil.validateEmail(text)) {
      return "Email is not valid";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordFinished) {
            Navigator.of(context).pushNamed(OtpPage.route, arguments: {
              "email": emailTextController.text,
              "fromRoute": ForgotPasswordPage.route
            });
          }
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close_rounded),
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(AppDimen.screenPadding),
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 150 - 50,
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
                        "You forgot password?",
                        style: AppStyle.mediumTitleStyleDark,
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
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      Text(
                        "*Please Enter the email address you used to log in to Shopfee to reset your password",
                        style: AppStyle.smallTextStyleDark,
                      ),
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
                        child: BlocBuilder<ForgotPasswordCubit,
                            ForgotPasswordState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is! ForgotPasswordInitial
                                  ? () {
                                      _cubit.goToOtpPage(
                                          emailTextController.text.trim());
                                    }
                                  : null,
                              child: const Text("Continue"),
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
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
