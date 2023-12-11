import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/personal_information/cubit/personal_information_cubit.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

class PersonalInformationScreen extends StatelessWidget {


  const PersonalInformationScreen({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalInformationCubit(
          userRepository: context.read<UserRepository>())
        ..initField(),
      child: BlocBuilder<PersonalInformationCubit, PersonalInformationState>(
        builder: (context, state) {
          if (state is PersonalInformationLoaded) {
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
                          Container(
                            width: 110,
                            height: 110,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "assets/images/img_default_user.png",
                                    ))),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 85, left: 75),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.fromBorderSide(BorderSide(
                                      color: AppColor.nonactiveColor))),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 16,
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
                          child: InputField(
                              title: "First Name",
                              value: state.user.firstName,
                              hint: "Input Your First Name",
                              callback: (String firstName) {
                                context
                                    .read<PersonalInformationCubit>()
                                    .updateFirstName(firstName);
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: InputField(
                              title: "Last Name",
                              value: state.user.lastName,
                              hint: "Input Your Last Name",
                              callback: (String lastName) {
                                context
                                    .read<PersonalInformationCubit>()
                                    .updateLastName(lastName);
                              }),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    InputField(
                      title: "Email",
                      hint: state.user.email,
                      isEnable: false,
                    ),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    // InputField(
                    //     title: "Phone",
                    //     hint: state.user.phoneNumber != null
                    //         ? state.user.phoneNumber!
                    //         : "Input your Phone Number",
                    //     callback: (String phoneNumber) {
                    //       context
                    //           .read<PersonalInformationCubit>()
                    //           .updatePhoneNumber(phoneNumber);
                    //     }),
                    // const SizedBox(
                    //   height: AppDimen.spacing,
                    // ),
                    Column(
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

                            DateTime initialDate = state.user.birthDate != null
                                ? state.user.birthDate!
                                : DateTime.now();
                            final DateTime? picked = await showDatePicker(
                              context: currentContext,
                              // Use the local variable here
                              initialDate: initialDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2025),
                            );
                            if (picked != null && picked != initialDate) {
                              context
                                  .read<PersonalInformationCubit>()
                                  .updateBirthday(picked);
                            }
                          },
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              label: state.user.birthDate != null
                                  ? Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(state.user.birthDate!),
                                      style: AppStyle.normalTextStyle
                                          .copyWith(color: const Color(0xff3C3C3C)))
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              suffixIcon:
                                  const Icon(Icons.calendar_month_outlined),
                              disabledBorder:
                                  AppStyle.outlineInputBorderDefault,
                              hintText: "Choose your birthday",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppDimen.spacing,
                    ),
                    Column(
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
                                            context
                                                .read<
                                                    PersonalInformationCubit>()
                                                .updateGender(Gender.MALE);
                                            Navigator.pop(contextPopup);
                                          },
                                          child: Text(
                                            'Male',
                                            style:
                                                TextStyle(color: AppColor.info),
                                          ),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            context
                                                .read<
                                                    PersonalInformationCubit>()
                                                .updateGender(Gender.FEMALE);
                                            Navigator.pop(contextPopup);
                                          },
                                          isDestructiveAction: true,
                                          child: Text(
                                            'Female',
                                            style:
                                                TextStyle(color: AppColor.info),
                                          ),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () {
                                            context
                                                .read<
                                                    PersonalInformationCubit>()
                                                .updateGender(Gender.OTHER);
                                            Navigator.pop(contextPopup);
                                          },
                                          isDestructiveAction: true,
                                          child: Text(
                                            'Other',
                                            style:
                                                TextStyle(color: AppColor.info),
                                          ),
                                        ),
                                      ],
                                      cancelButton: CupertinoActionSheetAction(
                                        onPressed: () {
                                          Navigator.pop(contextPopup);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ));
                          },
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                              label: state.user.gender != null
                                  ? Text(state.user.gender!.name,
                                      style: AppStyle.normalTextStyle
                                          .copyWith(color: const Color(0xff3C3C3C)))
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              suffixIcon: const Icon(Icons.arrow_drop_down),
                              disabledBorder:
                                  AppStyle.outlineInputBorderDefault,
                              hintText: "Choose your gender",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<PersonalInformationCubit>()
                                    .updateUser(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  disabledBackgroundColor:
                                      const Color(0xffCACACA),
                                  disabledForegroundColor: AppColor.lightColor,
                                  textStyle: AppStyle.mediumTextStyleDark,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                              child: const Text("Update"),
                            )))
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class InputField extends StatefulWidget {
  final String title;
  final String hint;
  final String? value;
  final bool isEnable;
  final Function(String)? callback;

  const InputField({
    required this.title,
    required this.hint,
    this.value,
    this.isEnable = true,
    this.callback,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        TextEditingController(text: widget.value != null ? widget.value! : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: AppStyle.normalTextStyle.copyWith(color: const Color(0xff3C3C3C)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: widget.title == "Phone" ? TextInputType.phone : null,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            widget.callback!(_controller.text);
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            return null;
          },
          enabled: widget.isEnable,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder: AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            disabledBorder: AppStyle.outlineInputBorderDefault,
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}
