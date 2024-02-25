import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/service/shared_service.dart';

class BaseService {
  static const String BACKEND_PATH = "http://10.0.2.2:8080/api/";
  static const String NOTIFY_PATH = "https://fcm.googleapis.com/fcm/send";
  static const String ADDRESS_PATH = "https://vapi.vnappmob.com/api/";
  static const String GOONG_PATH = "https://rsapi.goong.io/";

  //api backend route
  static const String productPath = "product";
  static const String categoryPath = "category";
  static const String transactionPath = "transaction";
  static const String authPath = "auth/user";
  static const String userPath = "user";
  static const String addressPath = "address";
  static const String orderPath = "order";

  //api goong route
  static const String geocodePath = "Geocode";

  late Dio dio;
  late Dio dioNotify;
  late Dio dioAddress;
  late Dio dioGoong;

  //CONSTRUCTOR
  BaseService() {
    //Backend dio
    dio = Dio(
      BaseOptions(
        baseUrl: BACKEND_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
    // final cookieJar = CookieJar();
    final cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage("${SharedService.getAppDocPath()}/.cookies/"),
    );
    dio.interceptors.addAll([
      CookieManager(cookieJar),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (SharedService.getAccessToken() != null) {
            options.headers['Authorization'] =
            "Bearer ${SharedService.getAccessToken()}";
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401 &&
              SharedService.getUserId() != null) {
            // If a 401 response is received, refresh the access token
            Map<String, dynamic> body = {
              "refreshToken": SharedService.getRefreshToken(),
            };
            try {
              var response = await dio
                  .post("${BaseService.authPath}/refresh-token", data: body);
              var result = Result(
                  success: response.data["success"],
                  message: response.data["message"],
                  data: response.data["data"]);

              if (result.success) {
                SharedService.setAccessToken(response.data!["accessToken"]);
                SharedService.setRefreshToken(response.data!["refreshToken"]);

                // Update the request header with the new access token
                e.requestOptions.headers['Authorization'] =
                'Bearer ${SharedService.getAccessToken()}';
              }
            } catch (e) {
              print(e);
            }
            // Repeat the request with the updated header
            return handler.resolve(await dio.fetch(e.requestOptions));
          }
          return handler.next(e);
        },
      ),
    ]);

    dioNotify = Dio(
      BaseOptions(
        // baseUrl: NOTIFY_PATH,
          connectTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          responseType: ResponseType.json,
          contentType: Headers.jsonContentType,
          headers: {
            'Authorization':
            "key=${FlutterConfig.get("FCM_API")}"
          }),
    );

    dioAddress = Dio(
      BaseOptions(
        baseUrl: ADDRESS_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );

    dioGoong = Dio(
      BaseOptions(
        baseUrl: GOONG_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
  }
}
