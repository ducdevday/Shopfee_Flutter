import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shopfee/core/base/base_service.dart';

class GoogleMapService extends BaseService {

  Future<Response> getAddressFromName(String addressString) async {
    Map<String, dynamic> queryParameters = {
      "address": addressString,
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await dioGoong.get("${BaseService.geocodePath}",
        queryParameters: queryParameters);
    return response;
  }

  Future<Response> getAddressFromPosition(double lat, double lng) async{
    Map<String, dynamic> queryParameters = {
      "latlng": "$lat,$lng",
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await dioGoong.get("${BaseService.geocodePath}",
        queryParameters: queryParameters);
    return response;
  }

}
