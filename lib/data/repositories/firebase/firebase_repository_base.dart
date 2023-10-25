
import 'package:shopfee/data/models/result.dart';

abstract class FirebaseRepositoryBase{
  Future<void> logInWithGoogle();
  Future<Result> getGoogleUser();
  Future<void> logoutWithGoogle();
}