import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/login/data/models/login_model.dart';

class LoginService{
  Future<Response> login(LoginModel loginModel) async {
    Map<String, dynamic> body = loginModel.toJson();
    final response =
        await DioService.instance.post("${DioService.authPath}/login", data: body);
    return response;
  }

  Future<Response> checkEmailExist(String email) async {
    Map<String, dynamic> queryParameters = {
      "email": email,
    };
    final response = await DioService.instance.get("${DioService.userPath}/registered",
        queryParameters: queryParameters);
    return response;
  }

  Future<void> logInWithGoogleFirebase() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<Response> logInWithGoogleServer(String idToken) async {
    final response = await DioService.instance.post("${DioService.authPath}/firebase/login",
        options: Options(
          headers: {"Id-token": idToken},
        ));
    return response;
  }

  Future<Response> registerWithGoogleServer(String idToken) async {
    final response = await DioService.instance.post("${DioService.authPath}/firebase/register",
        options: Options(
          headers: {"Id-token": idToken},
        ));
    return response;
  }

  Future<void> saveFCMToken(String userId) async {
    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set({"fcmToken": fcmToken});
  }
}
