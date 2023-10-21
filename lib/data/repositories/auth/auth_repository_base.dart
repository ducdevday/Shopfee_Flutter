import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';

abstract class AuthRepositoryBase extends BaseService{
  Future<Result> register(User user);
  Future<Result> sendCode(String email);
  Future<Result> resendCode(String email);
  Future<bool> verifyCode(String email, String code);
  Future<Result> login(String email, String password);
  Future<Result> passwordSendCode(String email);
  Future<Result> changePassword(String email, String password);
  Future<Result> changePasswordInAccount(String oldPassword, String newPassword);
  Future<Result> refreshToken();
}