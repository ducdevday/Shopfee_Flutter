import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/welcome/cubit/welcome_cubit.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

import '../widgets/input_field.dart';

class WelcomeScreen extends StatelessWidget {
  final bool? isInHome;

  const WelcomeScreen({Key? key, this.isInHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: BlocProvider(
        create: (context) => WelcomeCubit(
            authRepository: context.read<AuthRepository>(),
            firebaseRepository: context.read<FirebaseRepository>(),
            userRepository: context.read<UserRepository>(),
            localRepository: context.read<LocalRepository>())
          ..initCubit(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Builder(builder: (_){
                          if(isInHome == true){
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: AppColor.disableColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    iconSize: 16,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                    ),
                                  )),
                            );
                          }
                          return const SizedBox();
                        })
                      ]),
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
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: BlocConsumer<WelcomeCubit, WelcomeState>(
                      listener: (context, state) {
                        if (state is WelcomeExistEmail) {
                          buildShowExistEmailBottomSheet(context, state.email);
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
                    children: [
                      const Expanded(
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "or",
                          style: AppStyle.normalTextStyleDark,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          height: 2,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        context.read<WelcomeCubit>().loginWithGoogle(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: Colors.white),
                        child: SvgPicture.asset(
                          "assets/icons/ic_google.svg",
                          width: 32,
                          height: 32,
                        ),
                      ),
                    );
                  }),
                  const Spacer(
                    flex: 1,
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
                            Navigator.pushNamed(context, AppRouter.loginRoute);
                          },
                          child: Text(
                            "Login",
                            style: AppStyle.normalTextStylePrimary,
                          ))
                    ],
                  ),
                  Builder(builder: (context) {
                    if (isInHome == null) {
                      return Column(
                        children: [
                          TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, AppRouter.homeRoute);
                              },
                              child: Text(
                                "Continue as guess",
                                style: AppStyle.normalTextStylePrimary,
                              )),
                        ],
                      );
                    } else {
                      return const SizedBox(
                        height: 22,
                      );
                    }
                  }),
                ],
              ),
            )),
      ),
    );
  }
}

Future<void> buildShowExistEmailBottomSheet(
    BuildContext context, String email) {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
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
                    onPressed: () {}, icon: const Icon(Icons.close_rounded)),
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
                  icon: const Icon(Icons.close_rounded))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "It looks like you already have an account.\nPlease log in instead.",
            style: AppStyle.normalTextStyleDark,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
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
          const Spacer(
            flex: 1,
          ),
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.loginRoute,
                      arguments: email);
                },
                child: Text(
                  "Continue with this email",
                  style: AppStyle.normalTextStyle,
                ),
                style: AppStyle.elevatedButtonStylePrimary,
              )),
          const SizedBox(
            height: AppDimen.screenPadding,
          )
        ],
        // ),
      ),
    );
  }
}
