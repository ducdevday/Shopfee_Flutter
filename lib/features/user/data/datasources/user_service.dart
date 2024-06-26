import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/user/data/models/user_model.dart';

class UserService {
  Future<Response> getUser(String userId) async {
    final response = await DioService.instance.get(
      "${DioService.userPath}/$userId/view",
    );
    return response;
  }

  Future<Response> updateUser(UserModel user) async {
    final response = await DioService.instance
        .put("${DioService.userPath}/${user.id}", data: user.toJson());
    return response;
  }

  Future<Response> updatePhoneNumber(String userId, String phoneNumber) async {
    Map<String, dynamic> body = {"phoneNumber": phoneNumber};
    final response = await DioService.instance
        .patch("${DioService.userPath}/${userId}/add-phone-number", data: body);
    return response;
  }

  Future<Response> logout(String fcmTokenId) async {
    Map<String, dynamic> body = {
      "fcmTokenId": fcmTokenId,
    };
    final response = await DioService.instance
        .post("${DioService.authPath}/logout", data: body);
    return response;
  }

  Future<void> deleteFCMToken(String userId) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).delete();
  }

  Future<void> logoutWithGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
