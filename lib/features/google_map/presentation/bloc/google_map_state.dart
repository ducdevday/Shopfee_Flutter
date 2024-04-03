part of 'google_map_bloc.dart';

abstract class GoogleMapState extends Equatable {
  const GoogleMapState();
}

class GoogleMapInitial extends GoogleMapState {
  @override
  List<Object> get props => [];
}

class GoogleMapLoadSuccess extends GoogleMapState {
  final String? formattedString;
  final double currentLatPosition;
  final double currentLngPosition;

  const GoogleMapLoadSuccess(
      {this.formattedString,
      required this.currentLatPosition,
      required this.currentLngPosition});

  @override
  List<Object?> get props =>
      [formattedString, currentLatPosition, currentLngPosition];
}

class GoogleMapLoadFailure extends GoogleMapState {
  @override
  List<Object> get props => [];
}
