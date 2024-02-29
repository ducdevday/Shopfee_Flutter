import 'dart:io';

import 'package:shopfee/features/user/domain/entities/user_entity.dart';

abstract class PersonalInformationRepository {
  Future<void> updateUserInformation(String userId, UserEntity userEntity);

  Future<void> updateUserAvatar(String userId, File image);
}
