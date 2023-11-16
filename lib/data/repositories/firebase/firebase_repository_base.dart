import 'package:shopfee/data/base/notify_service.dart';
import 'package:shopfee/data/models/result.dart';

abstract class FirebaseRepositoryBase extends NotifyService{
  Future<void> logInWithGoogle();
  Future<Result> getGoogleUser();
  Future<void> logoutWithGoogle();
  Future<void> sendOrderMessage(String title, String body, String destinationId);
  Future<void> saveFCMToken(String userId);
  Future<void> deleteFCMToken(String userId);
}