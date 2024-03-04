part of otp;

class OtpCubit extends Cubit<OtpState> {
  final OtpUseCase _otpUseCase;

  OtpCubit(this._otpUseCase) : super(OtpInitial());

  Future<void> sendOTP(String email, String fromRoute) async {
    try {
      EasyLoading.show();
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
        if (registerEntity != null) {
          registerEntity.copyWith(code: currentState.otpsSting);
          var responseRegister = await _otpUseCase.register(registerEntity);
          SharedService.setToken(
              responseRegister.userId, responseRegister.accessToken);
        }
        EasyLoading.dismiss();
        emit(OtpFinished(code: currentState.otpsSting));
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }

  Future<void> resendOTP(String email, String fromRoute) async {
    if (state is OtpLoaded) {
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        await _otpUseCase.sendOtp(email, fromRoute);
        EasyLoading.dismiss();
        EasyLoading.showSuccess("Resend OTP to your email");
      } catch (e) {
        ExceptionUtil.handle(e);
      }
    }
  }
}
