import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final AuthRepository authRepository;
  WelcomeCubit({required this.authRepository}) : super(WelcomeInitial());

  Future<void> initCubit() async {
    emit(WelcomeLoaded());
  }

  Future<void> addEmail(String email) async {
    if (state is WelcomeLoaded) {
      emit(WelcomeLoaded(email: email));
    }
  }

  Future<void> sendOTP(BuildContext context) async {
    if (state is WelcomeLoaded) {
      final currentState = state as WelcomeLoaded;
      try{
        if(currentState.errorString() != ""){
          throw(currentState.errorString());
        }
        EasyLoading.show(status: 'Loading...', maskType: EasyLoadingMaskType.black);
        var response = await authRepository.sendCode(currentState.email);
        EasyLoading.dismiss();
        if(response){
          Navigator.pushNamed(context, "/otp", arguments: currentState.email);
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
