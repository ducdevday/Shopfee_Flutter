part of new_password;

class NewPasswordPage extends StatefulWidget {
  static const route = "/new_password";

  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  late final NewPasswordCubit _cubit;
  late final TextEditingController currentPasswordTextController;
  late final TextEditingController newPasswordTextController;
  late final TextEditingController confirmPasswordTextController;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<NewPasswordCubit>();
    currentPasswordTextController = TextEditingController();
    newPasswordTextController = TextEditingController();
    confirmPasswordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _cubit.close();
    currentPasswordTextController.dispose();
    newPasswordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.dispose();
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    if (type == FieldType.password &&
        !ValidateFieldUtil.validatePassword(text)) {
      return R.passwordCheck.tr();
    }
    if (type == FieldType.password &&
        newPasswordTextController.text.trim() !=
            confirmPasswordTextController.text.trim()) {
      return R.confirmPasswordCheck.tr();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close_rounded),
        ),
      ),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocConsumer<NewPasswordCubit, NewPasswordState>(
          listener: (context, state) {
            if (state is NewPasswordSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: AppDimen.screenPadding,
                  right: AppDimen.screenPadding,
                  bottom: AppDimen.screenPadding),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          R.changePassword.tr(),
                          style: AppStyle.largeTitleStyleDark,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "*${R.passwordCheck.tr()}",
                          style: AppStyle.smallTextStyleDark,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordInputField(
                      title: R.currentPassword.tr(),
                      hint: R.inputCurrentPassword.tr(),
                      validateField: (String value) =>
                          getErrorText(value, FieldType.password),
                      controller: currentPasswordTextController,
                      useFocus: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordInputField(
                      title: R.newPassword.tr(),
                      hint: R.inputNewPassword.tr(),
                      validateField: (String value) =>
                          getErrorText(value, FieldType.password),
                      controller: newPasswordTextController,
                      useFocus: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordInputField(
                      title: R.confirmPassword.tr(),
                      hint: R.inputConfirmPassword.tr(),
                      validateField: (String value) =>
                          getErrorText(value, FieldType.password),
                      controller: confirmPasswordTextController,
                      useFocus: false,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDimen.screenPadding),
                      child: ElevatedButton(
                        onPressed: () {
                          formKey.currentState?.validate();
                          _cubit.changePassword(
                              currentPasswordTextController.text.trim(),
                              newPasswordTextController.text.trim(),
                              confirmPasswordTextController.text.trim());
                        },
                        style: AppStyle.elevatedButtonStylePrimary,
                        child: Text(R.changePassword.tr()),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
