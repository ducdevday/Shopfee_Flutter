import 'package:shopfee/features/user/domain/entities/user_entity.dart';
import 'package:shopfee/features/user/domain/repositories/user_repository.dart';

abstract class UserUseCase {
  Future<UserEntity> getUser(String userId);

  Future<void> updateUser(UserEntity userEntity);

  Future<void> logoutUser(String userId);

  Future<void> updatePhoneNumber(String userId, String phoneNumber);
}

class UserUseCaseImpl extends UserUseCase {
  final UserRepository _userRepository;

  UserUseCaseImpl(this._userRepository);

  @override
  Future<UserEntity> getUser(String userId) async {
    return await _userRepository.getUser(userId);
  }

  @override
  Future<void> updateUser(UserEntity userEntity) async {
    await _userRepository.updateUser(userEntity);
  }

  @override
  Future<void> logoutUser(String userId) async {
    await _userRepository.logoutUser(userId);
  }

  @override
  Future<void> updatePhoneNumber(String userId, String phoneNumber) async{
    await _userRepository.updatePhoneNumber(userId, phoneNumber);
  }
}
