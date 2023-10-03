part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();
}
class LoadGeolocation extends GeolocationEvent {

  @override
  List<Object> get props => [];
}

class UpdateGeolocation extends GeolocationEvent {
  final Position position;

  UpdateGeolocation({required this.position});

  @override
  List<Object> get props => [position];
}