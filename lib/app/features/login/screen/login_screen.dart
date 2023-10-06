import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/login/cubit/login_cubit.dart';
import 'package:shopfee/app/features/login/widgets/input_field.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final String? email;

  const LoginScreen({Key? key, this.email}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit _cubit =
      LoginCubit(authRepository: context.read<AuthRepository>());

  @override
  void initState() {
    super.initState();
    _cubit.initField();
    if(widget.email != null){
      _cubit.addField("Email",widget.email!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
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
                    "Welcome Back!",
                    style: AppStyle.superLargeTitleStylePrimary,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  InputField(
                    title: "Email",
                    hint: "Input Your Email",
                    email: widget.email,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  InputField(
                    title: "Password",
                    hint: "Input Your Password",
                    isPassword: true,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/forgot_password");
                          },
                          child: Text(
                            "Forgot password?",
                            style: AppStyle.normalTextStylePrimary,
                          )))
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
                            onPressed: state.isValid()
                                ? () {
                                    context.read<LoginCubit>().doLogin(context);
                                  }
                                : null,
                            child: const Text("Login"),
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
                            Navigator.pushReplacementNamed(context, "/welcome");
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
        ),
      ),
    );
  }
}
