import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/welcome/cubit/welcome_cubit.dart';

import '../widgets/input_field.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: BlocBuilder<WelcomeCubit, WelcomeState>(
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
        ));
  }
}
