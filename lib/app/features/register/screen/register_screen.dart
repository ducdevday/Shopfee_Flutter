import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/register/cubit/register_cubit.dart';
import 'package:shopfee/app/features/register/widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => RegisterCubit()..initField(),
        child: Container(
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
                  const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InputField(
                          title: "First Name",
                          hint: "Input Your First Name",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: InputField(
                          title: "Last Name",
                          hint: "Input Your Last Name",
                        ),
                      )
                    ],
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
                  Text(
                    "By tapping \"Register\" you agree to our",
                    style: AppStyle.normalTextStyleDark,
                  ),
                  const SizedBox(
                    height: 4,
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
                            "Terms of Use",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(color: const Color(0xff032172)),
                          )),
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: Text(
                            " and ",
                            style: AppStyle.normalTextStyleDark,
                          )),
                      TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: Text(
                            "Privacy Policy",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(color: const Color(0xff032172)),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        if(state is RegisterLoaded) {
                          return ElevatedButton(
                            onPressed: state.isValid() ? () {} : null,
                            child: const Text("Register"),
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: const Color(0xffCACACA),
                                disabledForegroundColor: AppColor.lightColor,
                                textStyle: AppStyle.mediumTextStyleDark,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                )),
                          );
                        }
                        else {
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
