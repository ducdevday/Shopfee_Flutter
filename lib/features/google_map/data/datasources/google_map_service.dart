import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shopfee/core/base/goong_service.dart';

class GoogleMapService {
  Future<Response> getAutoCompletePlaceList(String input) async {
    Map<String, dynamic> queryParameters = {
      "input": input,
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await GoongService.instance.get(
        "${GoongService.autoCompletePath}",
        queryParameters: queryParameters);
    return response;
  }

  Future<Response> getAddressFromPlaceId(String placeId) async {
    Map<String, dynamic> queryParameters = {
      "place_id": placeId,
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await GoongService.instance
        .get("${GoongService.geocodePath}", queryParameters: queryParameters);
    return response;
  }

  Future<Response> getDistanceFrom2Place(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    Map<String, dynamic> queryParameters = {
      "origins": "$originLat,$originLng",
      "destinations": "$destinationLat,$originLng",
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await GoongService.instance
        .get("${GoongService.distancePath}", queryParameters: queryParameters);
    return response;
  }

  Future<Response> getAddressFromName(String addressString) async {
    Map<String, dynamic> queryParameters = {
      "address": addressString,
      "api_key": FlutterConfig.get("GOONG_API")
    };
    final response = await GoongService.instance
        .get("${GoongService.geocodePath}", queryParameters: queryParameters);
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
