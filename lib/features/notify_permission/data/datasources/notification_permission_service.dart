import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class NotifyPermissionService {
  Future<Response> saveFCMTokenToDB(String? userId, String? fcmToken) async {
    Map<String, dynamic> body = {
      "userId": userId,
      "token": fcmToken,
    };
    final response = await DioService.instance
        .post("${DioService.notificationPath}/user", data: body);
    return response;
  }
}
