import 'package:equatable/equatable.dart';

class Place extends Equatable{
  final String placeId;
  final String name;
  final double lat;
  final double lng;

  Place(
      {this.placeId = "", this.name = "", required this.lat, required this.lng});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json["place_id"],
      name: json["formatted_address"],
      lat: json["geometry"]["location"]["lat"],
      lng: json["geometry"]["location"]["lng"],
    );
  }

  @override
  List<Object> get props => [placeId, name, lat, lng];
}
