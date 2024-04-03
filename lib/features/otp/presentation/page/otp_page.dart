part of otp;

class OtpPage extends StatefulWidget {
  static const String route = "/otp";
  final String email;
  final String fromRoute;
  final RegisterEntity? registerEntity;

  const OtpPage({
    Key? key,
    required this.email,
    required this.fromRoute,
    this.registerEntity,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late OtpCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<OtpCubit>()
      ..sendOTP(widget.email, widget.fromRoute);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocConsumer<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpFinished) {
            switch (widget.fromRoute) {
              case ForgotPasswordPage.route:
                Navigator.of(context).pushNamedAndRemoveUntil(
                    ChangePasswordPage.route, (route) => false,
                    arguments: {"email": widget.email, "code": state.code});
                break;
              case RegisterPage.route:
                Navigator.of(context).pushNamedAndRemoveUntil(
                    DefaultPage.route, (route) => false);
                break;
            }
          }
        },
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
                      widget.email,
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
                          email: widget.email,
                          fromRoute: widget.fromRoute,
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
                                  context.read<OtpCubit>().verityOTP(
                                      email: widget.email,
                                      registerEntity: widget.registerEntity);
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
  final String fromRoute;

  const CountdownText({Key? key, required this.email, required this.fromRoute})
      : super(key: key);

  @override
  State<CountdownText> createState() => _CountdownTextState();
}

class _CountdownTextState extends State<CountdownText> {
  int _secondsLeft = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the State object is disposed.
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
          context.read<OtpCubit>().resendOTP(widget.email, widget.fromRoute);
        },
        child: Text(
          "Resend",
          style: AppStyle.normalTextStylePrimary,
        ));
  }
}
