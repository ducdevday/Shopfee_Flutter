import 'package:shopfee/core/common/models/my_token.dart';
import 'package:shopfee/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<MyToken> login(LoginEntity loginEntity);
  Future<MyToken> loginWithGoogle();
}