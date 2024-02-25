part of 'google_map_bloc.dart';

abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();
}

class GoogleMapLoadInitPosition extends GoogleMapEvent {
  final String? addressString;

  const GoogleMapLoadInitPosition({
    this.addressString,
  });

  @override
  List<Object?> get props => [addressString];
}

class GoogleMapMarkPosition extends GoogleMapEvent {
  final double latitude;
  final double longitude;

  const GoogleMapMarkPosition({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}
