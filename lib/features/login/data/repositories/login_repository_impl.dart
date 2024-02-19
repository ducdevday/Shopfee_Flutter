import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/login/data/datasources/login_service.dart';
import 'package:shopfee/features/login/data/models/login_model.dart';
import 'package:shopfee/features/login/data/models/user_google_model.dart';
import 'package:shopfee/features/login/domain/entities/login_entity.dart';
import 'package:shopfee/features/login/domain/repositories/login_repository.dart';
import 'package:shopfee/features/register/data/models/register_model.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginService _loginService;

  LoginRepositoryImpl(this._loginService);

  @override
  Future<MyToken> login(LoginEntity loginEntity) async {
    try {
      final response =
          await _loginService.login(LoginModel.fromEntity(loginEntity));
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );

      final token = MyToken.fromJson(result.data!);
      await _loginService.saveFCMToken(token.userId);
      return token;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          throw ServerFailure(message: "Account has been locked");
        } else if (e.response?.statusCode == 401) {
          throw ServerFailure(message: "Password is incorrect");
        } else if (e.response?.statusCode == 404) {
          throw ServerFailure(message: "Account doesn't exist");
        }
      }
      rethrow;
    }
  }

  Future<MyToken> register(RegisterEntity registerEntity) async {
    try {
      final response = await _loginService
          .register(RegisterModel.fromEntity(registerEntity));
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );
      final token = MyToken.fromJson(result.data!);
      await _loginService.saveFCMToken(token.userId);
      return token;
    } catch (e) {
      throw ServerFailure(message: "Register Account Fail! Please try again");
    }
  }

  @override
  Future<MyToken> loginWithGoogle() async {
    await _loginService.logInWithGoogle();
    final googleUser = UserGoogleModel(
        id: FirebaseAuth.instance.currentUser?.uid,
        email: FirebaseAuth.instance.currentUser?.email,
        displayName: FirebaseAuth.instance.currentUser?.displayName);
    try {
      final responseCheckEmailExist =
          await _loginService.checkEmailExist(googleUser.email!);
      final token = await login(
          LoginEntity(email: googleUser.email!, password: googleUser.id!));
      return token;
    } catch (e) {
      final fullname = googleUser.displayName!.split(" ").toList();
      String firstName = fullname.elementAt(0);
      String lastName = fullname.elementAt(fullname.length - 1);
      final token = await register(RegisterEntity(
          firstName: firstName,
          lastName: lastName,
          email: googleUser.email!,
          password: googleUser.id!));
      return token;
    }
  }
}
