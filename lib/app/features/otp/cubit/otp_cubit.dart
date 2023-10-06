import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository authRepository;
  OtpCubit({required this.authRepository}) : super(OtpInitial());

  Future<void> initOTP() async {
    emit(OtpLoaded(otps: ["","","","","",""]));
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

  Future<void> verityOTP(BuildContext context, String routeName, String email ) async{
    if(state is OtpLoaded){
      final currentState = state as OtpLoaded;
      try{
        EasyLoading.show(status: 'Verifying...', maskType: EasyLoadingMaskType.black);
        var response = await authRepository.verifyCode(email, currentState.otpsSting);
        EasyLoading.dismiss();
        if(response){
          Navigator.pushNamed(context, routeName, arguments: email);
        }
        else{
          EasyLoading.showError('OTP incorrect');
        }
      }
      catch(e){
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    }
  }

  Future<void> resendOTP(BuildContext context, String email, ) async {
    if (state is OtpLoaded) {
      try{
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        var response = await authRepository.resendCode(email);
        EasyLoading.dismiss();
        if(response.success){
          EasyLoading.showSuccess("Resend OTP to your email");
        }
        else{
          EasyLoading.showError('Something went wrong');
        }
      }
      catch(e){
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    }
  }
}
