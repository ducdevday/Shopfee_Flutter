import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/user/data/models/user_model.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';

class PersonalInformationService extends BaseService {
  Future<Response> updateUserInformation(
      String userId, UserEntity userEntity) async {
    UserModel userModel = UserModel.fromEntity(userEntity);
    Map<String, dynamic> body = userModel.toJson();

    final response = await dio.put("${BaseService.userPath}/$userId", data: body );

    return response;
  }

  Future<Response> updateUserAvatar(String userId, File image) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    final response = await dio
        .patch("${BaseService.userPath}/$userId/upload/avatar", data: formData);
    return response;
  }
}
