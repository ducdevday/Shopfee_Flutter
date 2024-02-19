import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void checkValidField(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) {
    if (ValidateFieldUtil.validateName(firstName) &&
        ValidateFieldUtil.validateName(lastName) &&
        ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePassword(password)) {
      print("RegisterCubit RegisterReady🚩🚩🚩");
      emit(RegisterReady());
    } else {
      print("RegisterCubit Not Ready🚩🚩🚩");
      emit(RegisterInitial());
    }
  }

  void goToOTPPage(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    // EasyLoading.show();
    // await Future.delayed(Duration(seconds: 1));
    // EasyLoading.dismiss();
    emit(RegisterFinished(
        registerEntity: RegisterEntity(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password)));
  }

// Future<void> doRegister(BuildContext context) async {
//   if (state is RegisterLoaded) {
//     final currentState = state as RegisterLoaded;
//     try {
//       EasyLoading.show(maskType: EasyLoadingMaskType.black);
//       var response = await authRepository.register(User(
//           firstName: currentState.firstName,
//           lastName: currentState.lastName,
//           email: currentState.email,
//           password: currentState.password));
//       EasyLoading.dismiss();
//       if (response.success) {
//         await doSaveUserAndGoHome(
//             userId: response.data!["userId"],
//             accessToken: response.data!["accessToken"],
//             refreshToken: response.data!["refreshToken"],
//             context: context);
//       } else {
//         EasyLoading.showError('Something went wrong');
//       }
//     } catch (e) {
//       print(e);
//       EasyLoading.showToast(e.toString());
//     }
//   }
// }

// Future<void> doSaveUserAndGoHome(
//     {required String userId,
//     required String accessToken,
//     required String refreshToken,
//     required BuildContext context}) async {
//   try {
//     await localRepository.saveUser(userId, accessToken, refreshToken);
//     await firebaseRepository.saveFCMToken(userId);
//
//     context
//         .read<HistoryBloc>()
//         .add(LoadHistory(historyStatus: HistoryStatus.Processing));
//     context.read<AccountBloc>().add(LoadAccount());
//     context.read<MyBottomNavigationBarCubit>().selectPage(0);
//
//     Navigator.pushNamedAndRemoveUntil(
//         context, AppRouter.homeRoute, (route) => false);
//   } catch (e) {
//     print(e);
//     EasyLoading.showToast(e.toString());
//   }
// }
}
