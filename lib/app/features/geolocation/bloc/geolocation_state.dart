part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();
}

class GeolocationInitial extends GeolocationState {
  @override
  List<Object> get props => [];
}

class GeolocationLoaded extends GeolocationState {
  final Position position;
  final List<PlaceSearch> placeSearchList;
  final PlaceSearch? placeSearchChoose;

  double get latitude => placeSearchChoose != null ? placeSearchChoose!.lat :  position.latitude;
  double get longitude => placeSearchChoose != null ? placeSearchChoose!.lng :  position.longitude;


  GeolocationLoaded({required this.position, this.placeSearchList = const [
  ], this.placeSearchChoose});

  @override
  List<Object?> get props => [position, placeSearchList, placeSearchChoose];

  @override
  String toString() {
    return 'GeolocationLoaded{' +
        ' position: $position,' +
        ' placeSearchChoose: $placeSearchChoose,' +
        '}';
  }

  GeolocationLoaded copyWith({
    Position? position,
    List<PlaceSearch>? placeSearchList,
    PlaceSearch? placeSearchChoose,
  }) {
    return GeolocationLoaded(
      position: position ?? this.position,
      placeSearchList: placeSearchList ?? this.placeSearchList,
      placeSearchChoose: placeSearchChoose ?? this.placeSearchChoose,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'position': this.position,
      'placeSearchList': this.placeSearchList,
      'placeSearchChoose': this.placeSearchChoose,
    };
  }

  factory GeolocationLoaded.fromMap(Map<String, dynamic> map) {
    return GeolocationLoaded(
      position: map['position'] as Position,
      placeSearchList: map['placeSearchList'] as List<PlaceSearch>,
      placeSearchChoose: map['placeSearchChoose'] as PlaceSearch,
    );
  }

}

class GeolocationError extends GeolocationState {
  @override
  List<Object> get props => [];
}
