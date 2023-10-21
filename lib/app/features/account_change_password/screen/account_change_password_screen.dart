import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/account_change_password/cubit/password_cubit.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

class AccountChangePasswordScreen extends StatelessWidget {
  const AccountChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false ,
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
        create: (context) =>
            PasswordCubit(authRepository: context.read<AuthRepository>())
              ..initPassword(),
        child: BlocConsumer<PasswordCubit, PasswordState>(
          listener: (context, state) {
            if (state is PasswordFinish) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is PasswordLoaded) {
              return Padding(
                padding: const EdgeInsets.only(
                    left: AppDimen.screenPadding,
                    right: AppDimen.screenPadding,
                    bottom: AppDimen.screenPadding),
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
                    PasswordField(
                      title: 'Current Password',
                      callback: (String value) {
                        context.read<PasswordCubit>().enterOldPassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordField(
                      title: 'New Password',
                      callback: (String value) {
                        context.read<PasswordCubit>().enterNewPassword(value);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    PasswordField(
                      title: 'Confirm New Password',
                      callback: (String value) {
                        context
                            .read<PasswordCubit>()
                            .enterConfirmPassword(value);
                      },
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                      child: ElevatedButton(
                        onPressed: state.changePasswordValid
                            ? () {
                                context.read<PasswordCubit>().changePassword();
                              }
                            : null,
                        child: const Text("Change Password"),
                        style: AppStyle.elevatedButtonStylePrimary,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final String title;
  final Function(String) callback;

  const PasswordField({
    required this.title,
    required this.callback,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppStyle.mediumTextStyleDark),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          onChanged: (value) => {widget.callback(value)},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please fill this section';
            }
            // else if (value.length < 6) {
            //   return 'Password must have greater or equal 6 characters';
            // }
            return null;
          },
          style: const TextStyle(fontSize: 14),
          obscureText: _passwordVisible,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                // Based on passwordVisible state choose the icon
                _passwordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColor.headingColor,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            contentPadding: const EdgeInsets.all(8),
            focusedErrorBorder: AppStyle.outlineInputBorderDefault,
            errorBorder: AppStyle.outlineInputBorderDefault,
            enabledBorder:AppStyle.outlineInputBorderDefault,
            focusedBorder: AppStyle.outlineInputBorderPrimary,
            hintText: widget.title,
          ),
        ),
      ],
    );
  }
}
