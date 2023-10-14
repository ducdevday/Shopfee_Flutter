import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/welcome/cubit/welcome_cubit.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

import '../widgets/input_field.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WelcomeCubit(authRepository: context.read<AuthRepository>())
            ..initCubit(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
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
                      "assets/images/img_logo_two.png",
                      width: 219.5,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Start a new journey",
                      style: AppStyle.superLargeTitleStylePrimary,
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    const InputField(
                      title: "Email",
                      hint: "Input Your Email",
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: BlocConsumer<WelcomeCubit, WelcomeState>(
                        listener: (context, state) {
                          if (state is WelcomeExistEmail) {
                            buildShowExistEmailBottomSheet(
                                context, state.email);
                          }
                        },
                        buildWhen: (previous, current) =>
                            current is! WelcomeExistEmail,
                        builder: (context, state) {
                          if (state is WelcomeLoaded) {
                            return ElevatedButton(
                              onPressed: state.isValid()
                                  ? () {
                                      context
                                          .read<WelcomeCubit>()
                                          .sendOTP(context);
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
                              Navigator.pushReplacementNamed(context, "/login");
                            },
                            child: Text(
                              "Login",
                              style: AppStyle.normalTextStylePrimary,
                            ))
                      ],
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
                          "or ",
                          style: AppStyle.normalTextStyleDark,
                        )),
                    TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: Text(
                          "Continue as guess",
                          style: AppStyle.normalTextStylePrimary,
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

Future<void> buildShowExistEmailBottomSheet(
    BuildContext context, String email) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return ExistEmailBottomSheet(email: email);
    },
  );
}

class ExistEmailBottomSheet extends StatelessWidget {
  final String email;

  const ExistEmailBottomSheet({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.close_rounded)),
              ),
              Text(
                "Account Already Exist",
                style: AppStyle.mediumTitleStyleDark,
              ),
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close_rounded))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "It looks like you already have an account.\nPlease log in instead.",
            style: AppStyle.normalTextStyleDark,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: AppDimen.spacing,
          ),
          Container(
            child: Image.asset(
              "assets/images/img_default_user.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Text(
          //   "User Name",
          //   style: AppStyle.mediumTitleStyleDark.copyWith(height: 1.75),
          // ),
          Spacer(
            flex: 1,
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/login", arguments: email);
                },
                child: Text(
                  "Continue with this email",
                  style: AppStyle.normalTextStyle,
                ),
                style: AppStyle.elevatedButtonStylePrimary,
              )),
          SizedBox(
            height: AppDimen.screenPadding,
          )
        ],
        // ),
      ),
    );
  }
}
