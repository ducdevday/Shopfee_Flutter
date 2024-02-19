part of otp;

class OtpCubit extends Cubit<OtpState> {
  final OtpUseCase _otpUseCase;

  OtpCubit(this._otpUseCase) : super(OtpInitial());

  Future<void> sendOTP(String email, String fromRoute) async {
    EasyLoading.show();
    try {
      await _otpUseCase.sendOtp(email, fromRoute);
      EasyLoading.dismiss();
    } catch (e) {
      ExceptionUtil.handle(e);
    }
    emit(OtpLoaded(otps: ["", "", "", "", "", ""]));
  }

  Future<void> addOTP(String number, int index) async {
    if (state is OtpLoaded) {
      final currentState = state as OtpLoaded;
      final updatedOtps = List<String>.from(currentState.otps);

      if (index >= 0 && index < updatedOtps.length) {
        updatedOtps[index] = number;
        emit(OtpLoaded(otps: updatedOtps));
      }
    }
  }

  Future<void> verityOTP(
      {required String email, required RegisterEntity? registerEntity}) async {
    if (state is OtpLoaded) {
      final currentState = state as OtpLoaded;
      try {
        EasyLoading.show(
            status: 'Verifying...', maskType: EasyLoadingMaskType.black);
        final responseVerifyOtp =
            await _otpUseCase.verifyOtp(email, currentState.otpsSting);
        EasyLoading.dismiss();
        if (registerEntity != null) {
          var responseRegister = await _otpUseCase.register(registerEntity);
          SharedService.setToken(responseRegister.userId,
              responseRegister.accessToken, responseRegister.refreshToken);
        }
        emit(OtpFinished());
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  Future<void> resendOTP(String email) async {
    if (state is OtpLoaded) {
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await _otpUseCase.resendOtp(email);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Resend OTP to your email");
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }
}
