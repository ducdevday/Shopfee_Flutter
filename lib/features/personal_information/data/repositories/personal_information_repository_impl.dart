import 'dart:io';

import 'package:shopfee/features/personal_information/data/datasources/personal_information_service.dart';
import 'package:shopfee/features/personal_information/domain/repositories/personal_information_repository.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';

class PersonalInformationRepositoryImpl
    implements PersonalInformationRepository {
  final PersonalInformationService _personalInformationService;

  PersonalInformationRepositoryImpl(this._personalInformationService);

  @override
  Future<void> updateUserInformation(
      String userId, UserEntity userEntity) async {
    final response = await _personalInformationService.updateUserInformation(
        userId, userEntity);
  }

  @override
  Future<void> updateUserAvatar(String userId, File image) async {
    final response =
        await _personalInformationService.updateUserAvatar(userId, image);
  }
}
