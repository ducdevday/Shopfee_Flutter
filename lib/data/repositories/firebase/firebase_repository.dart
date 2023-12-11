import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopfee/data/base/notify_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/repositories/firebase/firebase_repository_base.dart';

class FirebaseRepository extends FirebaseRepositoryBase {
  @override
  Future<void> logInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Result> getGoogleUser() async {
    try {
      Map<String, dynamic> googleUser = {
        "id": FirebaseAuth.instance.currentUser?.uid,
        "email": FirebaseAuth.instance.currentUser?.email,
        "displayName": FirebaseAuth.instance.currentUser?.displayName
      };
      return Result(
          success: true,
          message: "Sign in with Google Successfully",
          data: googleUser);
    } catch (e) {
      return Result(success: false, message: "Sign in with Google Fail");
    }
  }

  @override
  Future<void> logoutWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> sendOrderMessage(
    String title,
    String body,
    String destinationId,
  ) async {
    try {
      Map<String, dynamic> data = {
        "priority": "high",
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "status": "done",
          "body": body,
          "title": title,
          "destinationId": destinationId
        },
        "notification": {
          "title": title,
          "body": body,
          "android_channel_id": "shopfee"
        },
        "to": "/topics/orders"
      };
      await dio.post("${NotifyService.path}", data: data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> saveFCMToken(String userId) async {
    try {
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .set({"fcmToken": fcmToken});
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteFCMToken(String userId) async {
    await FirebaseFirestore.instance.collection("users").doc(userId).delete();
  }
}
