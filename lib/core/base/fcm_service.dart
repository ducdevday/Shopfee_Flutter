import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';

class FCMService {
  static const String FCM_PATH = "https://fcm.googleapis.com/fcm/send";

  late Dio _dio;
  static final FCMService _instance = FCMService._internal();

  static FCMService get instance {
    return _instance;
  }

  FCMService._internal() {
    initializeDio();
  }

  Future<void> initializeDio() async {
    _dio = Dio(
      BaseOptions(
        // baseUrl: FCM_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
        headers: {
          'Authorization':
          "key=${FlutterConfig.get("FCM_API")}"
        },
      ),
    );
  }

  Future<Response> get(String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.get(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> post(String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.post(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> put(String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return _dio.put(url,
        data: data, queryParameters: queryParameters, options: options);
  }

  Future<Response> patch(String url, {
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
}