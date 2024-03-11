import 'package:dio/dio.dart';

class GoongService {
  static const String GOONG_PATH = "https://rsapi.goong.io/";

  //api goong route
  static const String geocodePath = "Geocode";

  late Dio _dio;
  static final GoongService _instance = GoongService._internal();

  static GoongService get instance {
    return _instance;
  }

  GoongService._internal() {
    initializeDio();
  }

  Future<void> initializeDio() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: GOONG_PATH,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        responseType: ResponseType.json,
        contentType: Headers.jsonContentType,
      ),
    );
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
}
