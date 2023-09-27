import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/login/cubit/login_cubit.dart';
import 'package:shopfee/app/features/login/widgets/input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..initField(),
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
                    height: 75,
                  ),
                  SvgPicture.asset(
                    "assets/images/onboarding_one.svg",
                    width: 219.5,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  const InputField(
                    title: "Email",
                    hint: "Input Your Email",
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  const InputField(
                    title: "Password",
                    hint: "Input Your Password",
                    isPassword: true,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoaded) {
                          return ElevatedButton(
                            onPressed: state.isValid() ? () {} : null,
                            child: const Text("Login"),
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: const Color(
                                    0xffCACACA),
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
                            "Don’t have an account? ",
                            style: AppStyle.normalTextStyleDark,
                          )),
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/register");
                          },
                          child: Text(
                            "Register",
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
                        Navigator.pushReplacementNamed(
                            context, "/home");
                      },
                      child: Text(
                        "Continue as guess",
                        style: AppStyle.normalTextStylePrimary,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
