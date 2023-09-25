import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/otp/cubit/otp_cubit.dart';
import 'package:shopfee/app/features/otp/widgets/otp_box.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpCubit _cubit = OtpCubit();

  @override
  void initState() {
    super.initState();
    _cubit.initOTP();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text('Confirm OTP code'),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppDimen.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "081234567891",
                style: AppStyle.largeTitleStyleDark,
              ),
              Text(
                "Enter the 5-digit OTP code that has been sent from SMS to complete your account registration",
                style: AppStyle.normalTextStyleDark,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtpBox(cubit: _cubit, index: 0),
                  SizedBox(
                    width: 8,
                  ),
                  OtpBox(
                    cubit: _cubit,
                    index: 1,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  OtpBox(
                    cubit: _cubit,
                    index: 2,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  OtpBox(
                    cubit: _cubit,
                    index: 3,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  OtpBox(cubit: _cubit, index: 4, isLast: true),
                ],
              ),
              SizedBox(
                height: 20,
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
                        "Haven't got the confirmation code yet? ",
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
                        "Resend",
                        style: AppStyle.normalTextStylePrimary
                            .copyWith(color: AppColor.info),
                      )),
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                height: 48,
                width: double.infinity,
                child: BlocBuilder<OtpCubit, OtpState>(
                  builder: (context, state) {
                    if (state is OtpLoaded) {
                      return ElevatedButton(
                        onPressed: state.isValid() ? () {} : null,
                        child: Text("Confirm"),
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Color(0xffCACACA),
                            disabledForegroundColor: AppColor.lightColor,
                            textStyle: AppStyle.mediumTextStyleDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
