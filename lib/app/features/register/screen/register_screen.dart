import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/register/cubit/register_cubit.dart';
import 'package:shopfee/app/features/register/widgets/input_field.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';

class RegisterScreen extends StatelessWidget {
  final String email;

  const RegisterScreen({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => RegisterCubit(
            authRepository: context.read<AuthRepository>(),
            localRepository: context.read<LocalRepository>(),
            firebaseRepository: context.read<FirebaseRepository>())
          ..initField(email),
        child: Container(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                  InputField(
                    title: "Email",
                    hint: "Input Your Email",
                    email: email,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  InputField(
                    title: "Password",
                    hint: "Input Your Password",
                    isPassword: true,
                  ),
                ],
              ),
              Column(
                children: [
                  // Text(
                  //   "By tapping \"Register\" you agree to our",
                  //   style: AppStyle.normalTextStyleDark,
                  // ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //           minimumSize: Size.zero,
                  //           padding: EdgeInsets.zero,
                  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         ),
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Terms of Use",
                  //           style: AppStyle.normalTextStyleDark
                  //               .copyWith(color: const Color(0xff032172)),
                  //         )),
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //           minimumSize: Size.zero,
                  //           padding: EdgeInsets.zero,
                  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         ),
                  //         onPressed: () {},
                  //         child: Text(
                  //           " and ",
                  //           style: AppStyle.normalTextStyleDark,
                  //         )),
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //           minimumSize: Size.zero,
                  //           padding: EdgeInsets.zero,
                  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         ),
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Privacy Policy",
                  //           style: AppStyle.normalTextStyleDark
                  //               .copyWith(color: const Color(0xff032172)),
                  //         ))
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 14,
                  // ),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoaded) {
                          return ElevatedButton(
                            onPressed: state.isValid()
                                ? () {
                                    context
                                        .read<RegisterCubit>()
                                        .doRegister(context);
                                  }
                                : null,
                            child: const Text("Register"),
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
                  // const SizedBox(
                  //   height: 14,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //           minimumSize: Size.zero,
                  //           padding: EdgeInsets.zero,
                  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         ),
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Have an account? ",
                  //           style: AppStyle.normalTextStyleDark,
                  //         )),
                  //     TextButton(
                  //         style: TextButton.styleFrom(
                  //           minimumSize: Size.zero,
                  //           padding: EdgeInsets.zero,
                  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //         ),
                  //         onPressed: () {
                  //           Navigator.pushReplacementNamed(context, "/login");
                  //         },
                  //         child: Text(
                  //           "Login",
                  //           style: AppStyle.normalTextStylePrimary,
                  //         ))
                  //   ],
                  // ),
                  // TextButton(
                  //     style: TextButton.styleFrom(
                  //       minimumSize: Size.zero,
                  //       padding: EdgeInsets.zero,
                  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     ),
                  //     onPressed: () {
                  //     },
                  //     child: Text(
                  //       "or ",
                  //       style: AppStyle.normalTextStyleDark,
                  //     )),
                  // TextButton(
                  //     style: TextButton.styleFrom(
                  //       minimumSize: Size.zero,
                  //       padding: EdgeInsets.zero,
                  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.pushReplacementNamed(
                  //           context, "/home");
                  //     },
                  //     child: Text(
                  //       "Continue as guess",
                  //       style: AppStyle.normalTextStylePrimary,
                  //     )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
