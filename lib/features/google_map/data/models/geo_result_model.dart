import 'package:shopfee/features/template/domain/entities/template_entity.dart';

class GeoResultModel {
  final String formattedAddress;
  final double lat;
  final double lng;

  const GeoResultModel({
    required this.formattedAddress,
    required this.lat,
    required this.lng,
  });

  factory GeoResultModel.fromJson(Map<String, dynamic> json) {
    return GeoResultModel(
      formattedAddress: json["formatted_address"] as String,
      lat: json["geometry"]["location"]["lat"] as double,
      lng: json["geometry"]["location"]["lng"] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "formattedAddress": this.formattedAddress,
      "lat": this.lat,
      "lng": this.lng,
    };
  }
}
