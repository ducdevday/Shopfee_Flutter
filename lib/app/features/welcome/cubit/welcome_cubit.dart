import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/features/account/bloc/account_bloc.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository.dart';
import 'package:shopfee/data/repositories/local/local_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

part 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final AuthRepository authRepository;
  final FirebaseRepository firebaseRepository;
  final UserRepository userRepository;
  final LocalRepository localRepository;

  WelcomeCubit({
    required this.authRepository,
    required this.firebaseRepository,
    required this.userRepository,
    required this.localRepository,
  }) : super(WelcomeInitial());

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
      try {
        if (currentState.errorString() != "") {
          throw (currentState.errorString());
        }
        EasyLoading.show(
            status: 'Loading...', maskType: EasyLoadingMaskType.black);
        var response = await authRepository.sendCode(currentState.email);
        EasyLoading.dismiss();
        if (response.success) {
          Navigator.pushNamed(context, AppRouter.otpRoute, arguments: {
            "routeName": AppRouter.registerRoute,
            "email": currentState.email
          });
        } else if (response.message == "Email account registered") {
          showExistEmailBottomSheet(currentState.email);
        } else {
          EasyLoading.showError('Something went wrong');
        }
      } catch (e) {
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    if (state is WelcomeLoaded) {
      try {
        await firebaseRepository.logInWithGoogle();
        Result result = await firebaseRepository.getGoogleUser();
        Map<String, dynamic>? data = result.data;
        // ! Khi sử dụng login by google, Google userId được sử dụng làm password để đăng nhập/ đăng ký
        String userId = data!["id"];
        String email = data["email"];
        String displayName = data["displayName"];

        var responseCheckEmail = await userRepository.checkEmailExist(email);
        if (responseCheckEmail.success) {
          await doLoginGG(context, email: email, password: userId);
        } else {
          final fullname = displayName.split(" ").toList();
          String firstName = fullname.elementAt(0);
          String lastName = fullname.elementAt(fullname.length - 1);
          await doRegisterGG(context,
              email: email,
              firstName: firstName,
              lastName: lastName,
              password: userId);
        }
      } catch (e) {
        print(e.toString());
        EasyLoading.showError(e.toString());
      }
    }
  }

  Future<void> showExistEmailBottomSheet(String email) async {
    emit(WelcomeExistEmail(email: email));
    emit(WelcomeLoaded(email: email));
  }

  Future<void> doLoginGG(BuildContext context,
      {required String email, required String password}) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await authRepository.login(email, password);
      EasyLoading.dismiss();
      if (response.success) {
        await doSaveUserAndGoHome(userId: response.data!["userId"],accessToken: response.data!["accessToken"],refreshToken: response.data!["refreshToken"], context: context);
      } else {
        EasyLoading.showError('Invalid Email or Password');
      }
    } catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }

  Future<void> doRegisterGG(BuildContext context,
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      var response = await authRepository.register(User(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password));
      EasyLoading.dismiss();
      if (response.success) {
        await doSaveUserAndGoHome(userId: response.data!["userId"],accessToken: response.data!["accessToken"],refreshToken: response.data!["refreshToken"], context: context);
      } else {
        EasyLoading.showError('Something went wrong');
      }
    } catch (e) {
      print(e);
      EasyLoading.showToast(e.toString());
    }
  }

  Future<void> doSaveUserAndGoHome(
      {required String userId,
      required String accessToken,
      required String refreshToken,
      required BuildContext context}) async {
    await localRepository.saveUser(userId, accessToken, refreshToken);
    await firebaseRepository.saveFCMToken(userId);

    context
        .read<HistoryBloc>()
        .add(LoadHistory(historyStatus: HistoryStatus.Processing));
    context.read<AccountBloc>().add(LoadAccount());

    Navigator.pushNamedAndRemoveUntil(context,AppRouter.homeRoute, (route) => false);
  }
}
