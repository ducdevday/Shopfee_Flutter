import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/data/models/result.dart';

class BaseService {
  static const String BASE_PATH = "http://10.0.2.2:8080/api/";

  //api route
  static const String productPath = "product";
  static const String categoryPath = "category";
  static const String transactionPath = "transaction";
  static const String authPath = "auth";
  static const String userPath = "user";
  static const String addressPath = "address";
  static const String orderPath = "order";

  late Dio dio;

  //CONSTRUCTOR
  BaseService() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (GlobalData.ins.accessToken != null) {
            options.headers['Authorization'] =
                "Bearer ${GlobalData.ins.accessToken}";
            print(GlobalData.ins.accessToken);
          }
          return handler.next(options);
        },
        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401 && GlobalData.ins.userId != null) {
            // If a 401 response is received, refresh the access token
            Map<String, dynamic> body = {
              "refreshToken": GlobalData.ins.refreshToken,
            };
            try {
              var response = await dio
                  .post("${BaseService.authPath}/refresh-token", data: body);
              print(response.data);
              var result = Result(
                  success: response.data["success"],
                  message: response.data["message"],
                  data: response.data["data"]);

              if(result.success){
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('accessToken', response.data!["accessToken"]);
                await prefs.setString('refreshToken', response.data!["refreshToken"]);
                GlobalData.ins.accessToken = prefs.getString('accessToken');
                GlobalData.ins.refreshToken = prefs.getString('refreshToken');

                // Update the request header with the new access token
                e.requestOptions.headers['Authorization'] =
                'Bearer ${GlobalData.ins.accessToken}';
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
    );
  }
}