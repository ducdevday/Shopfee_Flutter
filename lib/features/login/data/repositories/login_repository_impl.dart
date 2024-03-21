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
          throw ServerFailure(message: "Account or Password is incorrect");
        } else if (e.response?.statusCode == 404) {
          throw ServerFailure(message: "Account doesn't exist");
        }
      }
      rethrow;
    }
  }

  @override
  Future<MyToken> loginWithGoogle() async {
    await _loginService.logInWithGoogleFirebase();
    final String? idToken =
        await FirebaseAuth.instance.currentUser?.getIdToken();
    final googleUser = UserGoogleModel(
        id: FirebaseAuth.instance.currentUser?.uid,
        email: FirebaseAuth.instance.currentUser?.email,
        displayName: FirebaseAuth.instance.currentUser?.displayName);
    final emailExist = await checkEmailExist(googleUser.email!);
    if (emailExist) {
      final response = await _loginService.logInWithGoogleServer(idToken!);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );

      final token = MyToken.fromJson(result.data!);
      await _loginService.saveFCMToken(token.userId);
      return token;
    } else {
      final response = await _loginService.registerWithGoogleServer(idToken!);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"],
      );

      final token = MyToken.fromJson(result.data!);
      await _loginService.saveFCMToken(token.userId);
      return token;
    }
  }

  Future<bool> checkEmailExist(String email) async {
    try {
      final response = await _loginService.checkEmailExist(email);
      final result = Result(
        success: response.data["success"],
        message: response.data["message"],
      );
      if (result.success) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
