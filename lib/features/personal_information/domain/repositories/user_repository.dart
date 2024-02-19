import 'package:shopfee/features/personal_information/domain/entities/user_entity.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';

abstract class UserRepository {
  Future<UserEntity> getUser(String userId);
  Future<void> updateUser(UserEntity userEntity);
  Future<void> logoutUser(String userId);
}