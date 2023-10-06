import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/otp/cubit/otp_cubit.dart';
import 'package:shopfee/app/features/otp/widgets/otp_box.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

class OtpScreen extends StatelessWidget {
  final String routeName;
  final String email;

  const OtpScreen({
    Key? key,
    required this.routeName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OtpCubit(authRepository: context.read<AuthRepository>())..initOTP(),
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          if (state is OtpLoaded) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Confirm OTP code'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      email,
                      style: AppStyle.largeTitleStyleDark,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Enter the 6-digit OTP code that has been sent from SMS to complete your account registration",
                      style: AppStyle.normalTextStyleDark,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OtpBox(index: 0),
                        SizedBox(
                          width: 8,
                        ),
                        OtpBox(
                          index: 1,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        OtpBox(
                          index: 2,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        OtpBox(
                          index: 3,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        OtpBox(index: 4),
                        SizedBox(
                          width: 8,
                        ),
                        OtpBox(index: 5, isLast: true),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Haven't got the confirmation code yet? ",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        CountdownText(
                          email: email,
                        ),
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Container(
                        height: 48,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isValid()
                              ? () {
                                  context
                                      .read<OtpCubit>()
                                      .verityOTP(context, routeName, email);
                                }
                              : null,
                          child: const Text("Confirm"),
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: const Color(0xffCACACA),
                              disabledForegroundColor: AppColor.lightColor,
                              textStyle: AppStyle.mediumTextStyleDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              )),
                        )),
                  ],
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}

class CountdownText extends StatefulWidget {
  final String email;

  const CountdownText({Key? key, required this.email}) : super(key: key);

  @override
  State<CountdownText> createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> {
  int _secondsLeft = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsLeft--;
      });
      if (_secondsLeft == 0) {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_secondsLeft != 0) {
      if (_secondsLeft >= 10) {
        return Text("00:${_secondsLeft.toString()}",
            style: AppStyle.normalTextStylePrimary);
      } else {
        return Text("00:0${_secondsLeft.toString()}",
            style: AppStyle.normalTextStylePrimary);
      }
    }
    return TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          context.read<OtpCubit>().resendOTP(context, widget.email);
        },
        child: Text(
          "Resend",
          style: AppStyle.normalTextStylePrimary,
        ));
  }
}
