import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/service/shared_service.dart';

class DioService {
  static const String BACKEND_PATH = "http://10.0.2.2:8080/api/";

  //api backend route
  static const String productPath = "product";
  static const String categoryPath = "category";
  static const String transactionPath = "transaction";
  static const String authPath = "auth/user";
  static const String userPath = "user";
  static const String addressPath = "address";
  static const String orderPath = "order";
  static const String branchPath = "branch";

  late Dio _dio;
  static final DioService _instance = DioService._internal();

  // factory DioService() {
  //   return _instance;
  // }

  // static DioService getInstance() {
  //   return _instance;
  // }

  static DioService get instance {
    return _instance;
  }

  DioService._internal() {
    initializeDio();
  }

  Future<void> initializeDio() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: BACKEND_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
    final cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage("${SharedService.getAppDocPath()}/.cookies/"),
    );

    _dio.interceptors.addAll([
      CookieManager(cookieJar),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Do something before request is sent
          if (SharedService.getAccessToken() != null) {
            options.headers['Authorization'] =
                "Bearer ${SharedService.getAccessToken()}";
          }
          return handler.next(options); // continue
        },

        onError: (DioError e, handler) async {
          if (e.response?.statusCode == 401 &&
              SharedService.getUserId() != null) {
            // If a 401 response is received, refresh the access token
            await setRefreshToken(e);
            // Repeat the request with the updated header
            return handler.resolve(await instance.fetch(e.requestOptions));
          }
          return handler.next(e); // continue
        },
        // ...
      ),
    ]);
  }

  Future<void> setRefreshToken(DioError e) async {
    try {
      var response =
          await instance.post("${DioService.authPath}/refresh-token");
      var result = Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);

      if (result.success) {
        SharedService.setAccessToken(response.data!["accessToken"]);
        // Update the request header with the new access token
        e.requestOptions.headers['Authorization'] =
            'Bearer ${SharedService.getAccessToken()}';
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Response> get(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> put(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> patch(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.patch(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> fetch(RequestOptions requestOptions) {
    return _dio.fetch(requestOptions);
  }

  Future<Response> delete(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.delete(url,
        data: data, queryParameters: queryParameters, options: options);
  }
}
