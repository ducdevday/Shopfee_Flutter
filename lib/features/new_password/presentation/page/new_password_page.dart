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
      return "Password must have greater or equal 6 digits";
    }
    if (type == FieldType.password &&
        newPasswordTextController.text.trim() !=
            confirmPasswordTextController.text.trim()) {
      return "New password and confirm password is not match";
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
                          "Change Password",
                          style: AppStyle.largeTitleStyleDark,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "*Password must have greater or equal 6 characters",
                          style: AppStyle.smallTextStyleDark,
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordInputField(
                      title: "Current Password",
                      hint: "Input Current Password",
                      validateField: (String value) =>
                          getErrorText(value, FieldType.password),
                      controller: currentPasswordTextController,
                      useFocus: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordInputField(
                      title: "New Password",
                      hint: "Input New Password",
                      validateField: (String value) =>
                          getErrorText(value, FieldType.password),
                      controller: newPasswordTextController,
                      useFocus: false,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordInputField(
                      title: "Confirm Password",
                      hint: "Input Confirm Password",
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
                        child: const Text("Change Password"),
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
