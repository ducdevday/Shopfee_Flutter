import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/user.dart';

abstract class AuthRepositoryBase extends BaseService{
  Future<bool> register(User user);
  Future<bool> sendCode(String email);
  Future<bool> verifyCode(String email, String code);
}