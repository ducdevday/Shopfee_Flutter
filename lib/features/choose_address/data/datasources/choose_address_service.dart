import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';

class ChooseAddressService extends BaseService {
  Future<Response> getListProvince() async {
    final response = await dioAddress.get("/province");
    return response;
  }

  Future<Response> getListDistrict(String provinceId) async {
    final response = await dioAddress.get("/province/district/$provinceId");
    return response;
  }

  Future<Response> getListWard(String districtId) async {
    final response = await dioAddress.get("/province/ward/$districtId");
    return response;
  }
}
