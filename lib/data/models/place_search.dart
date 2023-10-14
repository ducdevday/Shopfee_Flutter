import 'package:equatable/equatable.dart';

class PlaceSearch extends Equatable {
  final String placeId;
  final String name;
  final String formattedAddress;
  final double lat;
  final double lng;

  const PlaceSearch({
    required this.formattedAddress,
    required this.name,
    required this.placeId,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [formattedAddress, name, placeId, lat, lng];

  Map<String, dynamic> toMap() {
    return {
      'formattedAddress': this.formattedAddress,
      'name': this.name,
      'placeId': this.placeId,
      'lat': this.lat,
      'lng': this.lng,
    };
  }

  factory PlaceSearch.fromMap(Map<String, dynamic> map) {
    return PlaceSearch(
      formattedAddress: map['formatted_address'],
      name: map['name'] ?? "",
      placeId: map['place_id'],
      lat: map["geometry"]["location"]["lat"],
      lng: map["geometry"]["location"]["lng"],
    );
  }

}