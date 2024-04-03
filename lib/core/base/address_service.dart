import 'package:dio/dio.dart';

class AddressService {
  static const String ADDRESS_PATH = "https://vapi.vnappmob.com/api/";

  late Dio _dio;

  static final AddressService _instance = AddressService._internal();

  static AddressService get instance {
    return _instance;
  }

  AddressService._internal() {
    initializeDio();
  }

  void initializeDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ADDRESS_PATH,
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
