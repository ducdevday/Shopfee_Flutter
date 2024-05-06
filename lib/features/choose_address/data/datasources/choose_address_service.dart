import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shopfee/core/base/address_service.dart';
import 'package:shopfee/core/base/goong_service.dart';

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

  Future<Response> getAddressFromPosition(double lat, double lng) async {
    Map<String, dynamic> queryParameters = {
      "latlng": "$lat,$lng",
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await GoongService.instance
        .get("${GoongService.geocodePath}", queryParameters: queryParameters);
    return response;
  }
}
