import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';

class SavedAddressService  {
  Future<Response> getAllAddress(String userId) async {
    final response = await DioService.instance.get("${DioService.addressPath}/user/$userId");
    return response;
  }
}
