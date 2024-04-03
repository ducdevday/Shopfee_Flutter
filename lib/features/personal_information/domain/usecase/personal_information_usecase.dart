import 'dart:io';

import 'package:shopfee/features/personal_information/domain/repositories/personal_information_repository.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';

abstract class PersonalInformationUseCase {
  Future<void> updateUserInformation(String userId, UserEntity userEntity);

  Future<void> updateUserAvatar(String userId, File image);
}

class PersonalInformationUseCaseImpl extends PersonalInformationUseCase {
  final PersonalInformationRepository _personalInformationRepository;

  PersonalInformationUseCaseImpl(this._personalInformationRepository);

  @override
  Future<void> updateUserInformation(
      String userId, UserEntity userEntity) async {
    await _personalInformationRepository.updateUserInformation(
        userId, userEntity);
  }

  @override
  Future<void> updateUserAvatar(String userId, File image) async {
    await _personalInformationRepository.updateUserAvatar(userId, image);
  }
}
