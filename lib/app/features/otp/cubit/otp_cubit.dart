import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  Future<void> initOTP() async {
    emit(OtpLoaded(otps: ["","","","",""]));
  }

  Future<void> addOTP(String number, int index) async {
    if (state is OtpLoaded) {
      final currentState = state as OtpLoaded;
      final updatedOtps = List<String>.from(currentState.otps);

      if (index >= 0 && index < updatedOtps.length) {
        updatedOtps[index] = number;
        print(updatedOtps);
        emit(OtpLoaded(otps: updatedOtps));
      }
    }
  }
}
