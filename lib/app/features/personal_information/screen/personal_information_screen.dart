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
  final User user;

  const PersonalInformationScreen({Key? key, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalInformationCubit(
          userRepository: context.read<UserRepository>())
        ..initField(user),
      child: BlocBuilder<PersonalInformationCubit, PersonalInformationState>(
        builder: (context, state) {
          if (state is PersonalInformationLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Update Information"),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(AppDimen.screenPadding),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/images/img_default_user.png",
                                      ))),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 85, left: 75),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(BorderSide(
                                        color: AppColor.nonactiveColor))),
                                child: Icon(
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
                                value: user.firstName,
                                hint: "Input Your First Name",
                                callback: (String firstName) {
                                  context
                                      .read<PersonalInformationCubit>()
                                      .updateFirstName(firstName);
                                }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: InputField(
                                title: "Last Name",
                                value: user.lastName,
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
                        hint: user.email,
                        isEnable: false,
                      ),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      InputField(
                          title: "Phone",
                          hint: user.phoneNumber != null
                              ? user.phoneNumber!
                              : "Input your Phone Number",
                          callback: (String phoneNumber) {
                            context
                                .read<PersonalInformationCubit>()
                                .updatePhoneNumber(phoneNumber);
                          }),
                      const SizedBox(
                        height: AppDimen.spacing,
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Birthday",
                              style: AppStyle.normalTextStyle
                                  .copyWith(color: Color(0xff3C3C3C)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              // Capture the current context in a local variable
                              BuildContext currentContext = context;

                              DateTime initialDate =
                              user.birthDate != null ? user.birthDate! : DateTime.now();
                              final DateTime? picked = await showDatePicker(
                                context: currentContext, // Use the local variable here
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
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                suffixIcon:
                                    const Icon(Icons.calendar_month_outlined),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(16)),
                                hintText: state.user.birthDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(state.user.birthDate!)
                                    : "Choose your birthday",
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
                                  .copyWith(color: Color(0xff3C3C3C)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext contextDialog) {
                                    return SimpleDialog(
                                      title: const Text('Select your gender'),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                          onPressed: () {
                                            context.read<PersonalInformationCubit>().updateGender(Gender.MALE);
                                            Navigator.pop(contextDialog);
                                          },
                                          child: const Text('Male   ♂️'),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () {
                                            context.read<PersonalInformationCubit>().updateGender(Gender.FEMALE);
                                            Navigator.pop(contextDialog);
                                          },
                                          child: const Text('Female   ♀️'),
                                        ),
                                        SimpleDialogOption(
                                          onPressed: () {
                                            context.read<PersonalInformationCubit>().updateGender(Gender.OTHER);
                                            Navigator.pop(contextDialog);
                                          },
                                          child: const Text('Other 💫'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(16)),
                                hintText:state.user.gender != null ? state.user.gender!.name : "Choose your gender" ,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<PersonalInformationCubit>().updateUser(context);
                                },
                                child: Text("Update"),
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    disabledBackgroundColor:
                                        const Color(0xffCACACA),
                                    disabledForegroundColor:
                                        AppColor.lightColor,
                                    textStyle: AppStyle.mediumTextStyleDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                              )))
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            return SizedBox();
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
    _controller = TextEditingController(text: widget.value != null ? widget.value! : "");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            widget.title,
            style: AppStyle.normalTextStyle.copyWith(color: Color(0xff3C3C3C)),
          ),
        ),
        SizedBox(
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
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            hintText: widget.hint,
          ),
        ),
      ],
    );
  }
}
