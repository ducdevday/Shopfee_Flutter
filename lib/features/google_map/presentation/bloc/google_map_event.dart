part of 'google_map_bloc.dart';

abstract class GoogleMapEvent extends Equatable {
  const GoogleMapEvent();
}

class GoogleMapEnterAddressNoText extends GoogleMapEvent {
  final String input;

  const GoogleMapEnterAddressNoText({
    required this.input,
  });

  @override
  List<Object> get props => [input];
}

class GoogleMapSelectPlace extends GoogleMapEvent {
  final AutoCompleteResultEntity autoCompleteResultEntity;

  const GoogleMapSelectPlace({
    required this.autoCompleteResultEntity,
  });

  @override
  List<Object> get props => [autoCompleteResultEntity];
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

class GoogleMapConfirmDone extends GoogleMapEvent {
  @override
  List<Object> get props => [];
}
