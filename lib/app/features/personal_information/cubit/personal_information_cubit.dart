import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

part 'personal_information_state.dart';

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  final UserRepository userRepository;

  PersonalInformationCubit({required this.userRepository})
      : super(PersonalInformationInitial());

  Future<void> initField() async {
    try{
      if(GlobalData.ins.userId!.isNotEmpty){
        // var response = await userRepository.getUser(GlobalData.ins.userId!, GlobalData.ins.accessToken!);
        var response = await userRepository.getUser(GlobalData.ins.userId!);

        if(response.success){
          final User user = User.fromJson(response.data!);
          emit(PersonalInformationLoaded(user: user));
        }
      }
    }
    catch(e){
      print(e);
    }
  }

  Future<void> updateFirstName(String firstName) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          user: currentState.user.copyWith(firstName: firstName)));
    }
  }

  Future<void> updateLastName(String lastName) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          user: currentState.user.copyWith(lastName: lastName)));
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          user: currentState.user.copyWith(phoneNumber: phoneNumber)));
    }
  }

  Future<void> updateBirthday(DateTime birthdate) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          user: currentState.user.copyWith(birthDate: birthdate)));
    }
  }

  Future<void> updateGender(Gender gender) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      emit(PersonalInformationLoaded(
          user: currentState.user.copyWith(gender: gender)));
    }
  }

  Future<void> updateUser(BuildContext context) async {
    if (state is PersonalInformationLoaded) {
      final currentState = state as PersonalInformationLoaded;
      try {
        EasyLoading.show();
        var response = await userRepository.updateUser(currentState.user);
        EasyLoading.dismiss();
        if (response.success) {
          EasyLoading.showInfo("Update Information Successfully",
              duration: Duration(milliseconds: 3000));
          Future.delayed(Duration(milliseconds: 3000), () {
            Navigator.pop(context);
          });
        } else {
          EasyLoading.showError('Something went wrong',
              duration: Duration(milliseconds: 3000));
        }
      } catch (e) {
        print(e);
        EasyLoading.showToast(e.toString());
      }
    }
  }
}
