import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class SavedAddressService extends BaseService {
  Future<Response> getAllAddress(String userId) async {
    final response = await dio.get("${BaseService.addressPath}/user/$userId");
    return response;
  }
}
