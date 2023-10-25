import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

import '../widgets/input_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(authRepository: context.read<AuthRepository>())..initCubit(),
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
                      "assets/images/img_logo_two.png",
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
                    const InputField(
                      title: "Email",
                      hint: "Input Your Email",
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
                      child: BlocBuilder<
                          ForgotPasswordCubit,
                          ForgotPasswordState>(
                        builder: (context, state) {
                          if (state is ForgotPasswordLoaded) {
                            return ElevatedButton(
                              onPressed: state.isValid()
                                  ? () {
                                context
                                    .read<ForgotPasswordCubit>()
                                    .sendOTP(context);
                                // buildShowExistEmailBottomSheet(context);
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
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
