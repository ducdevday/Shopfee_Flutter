import 'package:dio/dio.dart';

class NotifyService {
  static const String path = "https://fcm.googleapis.com/fcm/send";

  late Dio dio;

  //CONSTRUCTOR
  NotifyService() {
    dio = Dio(
      BaseOptions(
        baseUrl: path,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
        headers: {
          'Authorization' : "key=AAAALjRbZjM:APA91bHRTExSmHLyQFtcDQI2j-2udvkbTIMj4X3d1iBbZyyhchw2lJsZ3CLwkSfM3b5cPTOzRarHvSHEY12rQtMvHXQVaPmxWb9veXl3iVu4UpoBzwvCXfz-JZXCVN3OJ8bU4_HX0f_R"
        }
      ),
    );
  }
}