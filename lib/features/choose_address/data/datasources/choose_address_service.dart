import 'package:dio/dio.dart';
import 'package:shopfee/core/base/address_service.dart';

class ChooseAddressService {
  Future<Response> getListProvince() async {
    final response = await AddressService.instance.get("/province");
    return response;
  }

  Future<Response> getListDistrict(String provinceId) async {
    final response = await AddressService.instance.get("/province/district/$provinceId");
    return response;
  }

  Future<Response> getListWard(String districtId) async {
    final response = await AddressService.instance.get("/province/ward/$districtId");
    return response;
  }
}
