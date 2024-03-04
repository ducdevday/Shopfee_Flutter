part of personal_information;

class PersonalInformationPage extends StatefulWidget {
  static const String route = "/personal_information";

  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  State<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  late final PersonalInformationCubit _cubit;
  late final TextEditingController firstNameTextController;
  late final TextEditingController lastNameTextController;
  late final TextEditingController emailTextController;
  late final TextEditingController phoneTextController;
  late final ValueNotifier<Gender?> genderListener;
  late final ValueNotifier<DateTime?> birthDayListener;
  ValueNotifier<File?> avatarListener = ValueNotifier(null);
  String? avatarUrl;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<PersonalInformationCubit>();

    final userState = context.read<UserBloc>().state;
    if (userState is UserLoadSuccess) {
      final user = userState.user;
      firstNameTextController = TextEditingController(text: user.firstName);
      lastNameTextController = TextEditingController(text: user.lastName);
      emailTextController = TextEditingController(text: user.email);
      phoneTextController = TextEditingController(text: user.phoneNumber);
      genderListener = ValueNotifier(user.gender);
      birthDayListener = ValueNotifier(user.birthDate);
      avatarUrl = user.avatarUrl;
    }
  }

  String? getErrorText(
    String text,
    FieldType type,
  ) {
    //Todo: Check All Field validator
    _cubit.checkValidField(
        firstName: firstNameTextController.text,
        lastName: lastNameTextController.text,
        phoneNumber: phoneTextController.text);
    if (type == FieldType.firstName && !ValidateFieldUtil.validateName(text)) {
      return "First name is not valid";
    } else if (type == FieldType.lastName &&
        !ValidateFieldUtil.validateName(text)) {
      return "Last name is not valid";
    } else if (type == FieldType.phone &&
        (text.isNotEmpty && !ValidateFieldUtil.validatePhone(text))) {
      return "Phone number is not valid";
    }
    return null;
  }

  void uploadAvatarUserFromGallery() async {
    try {
      final resultImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (resultImage != null) {
        avatarListener.value = File(resultImage.path);
      }
    } catch (e) {
      print(e);
    }
  }

  void uploadAvatarUserFromCamera() async {
    try {
      final resultImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (resultImage != null) {
        avatarListener.value = File(resultImage.path);
      }
    } catch (e) {
      print(e);
    }
  }

  void showChooseAvatarDialog() {
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) => MyConfirmDialog(
              title: "Upload Your Avatar",
              content: "Choose From",
              cancelText: "Gallery",
              confirmText: "Camera",
              callbackOK: () async {
                Navigator.of(dialogContext).pop();
                uploadAvatarUserFromCamera();
              },
              callbackCancel: () async {
                Navigator.of(dialogContext).pop();
                uploadAvatarUserFromGallery();
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocConsumer<PersonalInformationCubit, PersonalInformationState>(
        listener: (context, state) {
          if (state is PersonalInformationFinished) {
            context.read<UserBloc>().add(UserLoadInformation());
            NavigationUtil.pop();
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Update Information"),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        ValueListenableBuilder<File?>(
                          valueListenable: avatarListener,
                          builder: (BuildContext context, avatarFile,
                              Widget? child) {
                            if (avatarFile != null) {
                              return Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(avatarFile))),
                              );
                            } else {
                              if (avatarUrl == null) {
                                return Container(
                                  width: 110,
                                  height: 110,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            AppPath.imgDefaultAvatar,
                                          ))),
                                );
                              } else {
                                return Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            avatarUrl!,
                                          ))),
                                );
                              }
                            }
                          },
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 85, left: 75),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.fromBorderSide(BorderSide(
                                    color: AppColor.nonactiveColor))),
                            child: GestureDetector(
                              onTap: (){
                                showChooseAvatarDialog();
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      const SizedBox(
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
                    isEnable: false,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  PhoneInputField(
                    title: "Phone Number",
                    hint: "Input Your Phone Number",
                    validateField: (String value) =>
                        getErrorText(value, FieldType.phone),
                    controller: phoneTextController,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  ValueListenableBuilder(
                    valueListenable: birthDayListener,
                    builder: (BuildContext context, DateTime? birthDate,
                        Widget? child) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Birthday",
                              style: AppStyle.normalTextStyle
                                  .copyWith(color: const Color(0xff3C3C3C)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              // Capture the current context in a local variable
                              BuildContext currentContext = context;

                              DateTime initialDate =
                                  birthDate ?? DateTime.now();
                              final DateTime? picked = await showDatePicker(
                                context: currentContext,
                                // Use the local variable here
                                initialDate: initialDate,
                                firstDate: DateTime(1970),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null && picked != initialDate) {
                                birthDayListener.value = picked;
                              }
                            },
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  label: birthDate == null
                                      ? null
                                      : Text(
                                          FormatUtil.formatBirthDay(
                                              birthDate),
                                          style:
                                              TextStyle(color: Colors.black)),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  suffixIcon:
                                      const Icon(Icons.calendar_month_outlined),
                                  focusedErrorBorder:
                                      AppStyle.outlineInputBorderDefault,
                                  errorBorder:
                                      AppStyle.outlineInputBorderDefault,
                                  enabledBorder:
                                      AppStyle.outlineInputBorderDefault,
                                  focusedBorder:
                                      AppStyle.outlineInputBorderPrimary,
                                  disabledBorder:
                                      AppStyle.outlineInputBorderDefault,
                                  hintText: "Choose your birthday",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  ValueListenableBuilder(
                    valueListenable: genderListener,
                    builder:
                        (BuildContext context, Gender? gender, Widget? child) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Gender",
                              style: AppStyle.normalTextStyle
                                  .copyWith(color: const Color(0xff3C3C3C)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext contextPopup) =>
                                      CupertinoActionSheet(
                                        title: const Text("Choose your gender"),
                                        actions: [
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              genderListener.value =
                                                  Gender.MALE;
                                              Navigator.pop(contextPopup);
                                            },
                                            child: Text(
                                              'Male',
                                              style: TextStyle(
                                                  color: AppColor.info),
                                            ),
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              genderListener.value =
                                                  Gender.FEMALE;
                                              Navigator.pop(contextPopup);
                                            },
                                            isDestructiveAction: true,
                                            child: Text(
                                              'Female',
                                              style: TextStyle(
                                                  color: AppColor.info),
                                            ),
                                          ),
                                          CupertinoActionSheetAction(
                                            onPressed: () {
                                              genderListener.value =
                                                  Gender.OTHER;
                                              Navigator.pop(contextPopup);
                                            },
                                            isDestructiveAction: true,
                                            child: Text(
                                              'Other',
                                              style: TextStyle(
                                                  color: AppColor.info),
                                            ),
                                          ),
                                        ],
                                        cancelButton:
                                            CupertinoActionSheetAction(
                                          onPressed: () {
                                            Navigator.pop(contextPopup);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ));
                            },
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                  label: gender == null
                                      ? null
                                      : Text(
                                          gender.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  disabledBorder:
                                      AppStyle.outlineInputBorderDefault,
                                  hintText: "Choose your gender",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: double.infinity,
                          child: BlocBuilder<PersonalInformationCubit,
                              PersonalInformationState>(
                            builder: (context, state) {
                              return ElevatedButton(
                                onPressed: state is! PersonalInformationInitial
                                    ? () {
                                        context
                                            .read<PersonalInformationCubit>()
                                            .updateUser(UserEntity(
                                                firstName:
                                                    firstNameTextController.text
                                                        .trim(),
                                                lastName: lastNameTextController
                                                    .text
                                                    .trim(),
                                                email: emailTextController.text
                                                    .trim(),
                                                phoneNumber: FormatUtil
                                                    .formatOriginalPhone(
                                                        phoneTextController.text
                                                            .trim()),
                                                gender: genderListener.value,
                                                birthDate:
                                                    birthDayListener.value), avatarListener.value);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    disabledBackgroundColor:
                                        const Color(0xffCACACA),
                                    disabledForegroundColor:
                                        AppColor.lightColor,
                                    textStyle: AppStyle.mediumTextStyleDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                child: const Text("Update"),
                              );
                            },
                          )))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
