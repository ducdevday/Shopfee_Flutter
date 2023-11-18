import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/change_password/cubit/change_password_cubit.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/app/features/change_password/widget/input_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  final String? email;

  const ChangePasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ChangePasswordCubit(authRepository: context.read<AuthRepository>())
        ..initField(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(AppDimen.screenPadding),
          child: Column(
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
                    "Update Your Password",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  InputField(
                    title: "New Password",
                    hint: "Input Your New Password",
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  InputField(
                    title: "Confirm Password",
                    hint: "Input Your Confirm Password",
                    isPassword: true,
                  ),
                  const SizedBox(
                      height: AppDimen.spacing
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "*Password must have greater or equal 6 characters",
                        style: AppStyle.smallTextStyleDark,
                      )),
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
                    child:
                    BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                      listener: (context, state) {
                        if(state is ChangePasswordSuccess){
                          Navigator.pushNamedAndRemoveUntil(context,AppRouter.loginRoute, ModalRoute.withName('/'));
                        }
                      },
                      builder: (context, state) {
                        return BlocBuilder<
                            ChangePasswordCubit,
                            ChangePasswordState>(
                          builder: (context, state) {
                            if (state is ChangePasswordLoaded) {
                              return ElevatedButton(
                                onPressed: state.isValid()
                                    ? () {
                                  context
                                      .read<ChangePasswordCubit>()
                                      .changePassword(context, email!);
                                }
                                    : null,
                                child: const Text("Update"),
                                style: ElevatedButton.styleFrom(
                                    disabledBackgroundColor:
                                    const Color(0xffCACACA),
                                    disabledForegroundColor: AppColor
                                        .lightColor,
                                    textStyle: AppStyle.mediumTextStyleDark,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    )),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
