part of otp;

abstract class OtpState extends Equatable {
  const OtpState();
}

class OtpInitial extends OtpState {
  @override
  List<Object> get props => [];
}

class OtpLoaded extends OtpState {
  final List<String> otps;

  OtpLoaded({required this.otps});

  @override
  List<Object> get props => [otps];

  bool isValid() {
    if (otps.contains("")) return false;
    return true;
  }

  String get otpsSting => otps.join("");
}

class OtpFinished extends OtpState {
  final String code;

  const OtpFinished({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}
