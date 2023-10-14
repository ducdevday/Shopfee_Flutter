import 'package:equatable/equatable.dart';

class PlaceAutoComplete extends Equatable{
  final String description;
  final String placeId;

  PlaceAutoComplete({required this.description, required this.placeId});

  factory PlaceAutoComplete.fromJson(Map<String, dynamic> json) {
    return PlaceAutoComplete(
      description: json["description"],
      placeId: json["place_id"],
    );
  }

  @override
  List<Object> get props => [description, placeId];
}