import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/register/data/models/register_model.dart';

class OtpService {
  Future<Response> sendOtpToRegister(String email) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    final response = await DioService.instance
        .post("${DioService.authPath}/register/send-code", data: body);
    return response;
  }

  Future<Response> sendOtpToChangePassword(String email) async {
    Map<String, dynamic> body = {
      "email": email,
    };
    final response = await DioService.instance
        .post("${DioService.authPath}/password/send-code", data: body);
    return response;
  }

  Future<Response> verifyOtp(String email, String code) async {
    Map<String, dynamic> body = {
      "email": email,
      "code": code,
    };
    final response =
        await DioService.instance.post("${DioService.authPath}/verify", data: body);
    return response;
  }

  Future<Response> register(RegisterModel registerModel) async {
    Map<String, dynamic> body = registerModel.toJson();
    final response =
        await DioService.instance.post("${DioService.authPath}/register", data: body);
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
