import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/user/data/datasources/user_service.dart';
import 'package:shopfee/features/user/data/models/user_model.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';
import 'package:shopfee/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService _userService;

  UserRepositoryImpl(this._userService);

  @override
  Future<UserEntity> getUser(String userId) async {
    final response = await _userService.getUser(userId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final userModel = UserModel.fromJson(result.data!);
    final userEntity = UserEntity.fromModel(userModel);
    return userEntity;
  }

  @override
  Future<void> updateUser(UserEntity userEntity) async {
    final response =
        await _userService.updateUser(UserModel.fromEntity(userEntity));
  }

  @override
  Future<void> logoutUser(String userId) async {
    await _userService.logout();
    await _userService.deleteFCMToken(userId);
    await _userService.logoutWithGoogle();
  }
}
