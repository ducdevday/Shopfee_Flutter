part of 'otp_cubit.dart';

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
