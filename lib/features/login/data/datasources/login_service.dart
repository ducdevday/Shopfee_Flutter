import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/login/data/models/login_model.dart';
import 'package:shopfee/features/register/data/models/register_model.dart';

class LoginService extends BaseService {
  Future<Response> login(LoginModel loginModel) async {
    Map<String, dynamic> body = loginModel.toJson();
    final response =
        await dio.post("${BaseService.authPath}/login", data: body);
    return response;
  }

  Future<Response> register(RegisterModel registerModel) async {
    Map<String, dynamic> body = registerModel.toJson();
    // final response =
    //     await dio.post("${BaseService.authPath}/user/register", data: body);

    final response =
        await dio.post("${BaseService.authPath}/register", data: body);
    return response;
  }

  Future<Response> checkEmailExist(String email) async {
    Map<String, dynamic> queryParameters = {"email": email};
    final response = await dio.get("${BaseService.userPath}/existed",
        queryParameters: queryParameters);
    return response;
  }

  Future<void> logInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Future<void> saveFCMToken(String userId) async {
    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set({"fcmToken": fcmToken});
  }
}
