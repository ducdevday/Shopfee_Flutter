part of 'geolocation_bloc.dart';

abstract class GeolocationState  extends Equatable{}

class GeolocationInitial extends GeolocationState {
  @override
  List<Object> get props => [];
}

class GeolocationLoading extends GeolocationState {
  @override
  List<Object?> get props => [];
}

class GeolocationLoaded extends GeolocationState {
  final Position position;

  GeolocationLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

class GeolocationError extends GeolocationState {
  @override
  List<Object> get props => [];
}
