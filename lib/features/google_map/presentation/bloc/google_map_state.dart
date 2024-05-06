part of google_map;

abstract class GoogleMapState extends Equatable {
  const GoogleMapState();
}

class GoogleMapInitial extends GoogleMapState {
  @override
  List<Object> get props => [];
}

class GoogleMapLoadInProcess extends GoogleMapState {
  @override
  List<Object> get props => [];
}

class GoogleMapPhase1State extends GoogleMapState {
  final List<AutoCompleteResultEntity> autoCompletePlaceList;

  const GoogleMapPhase1State({
    required this.autoCompletePlaceList,
  });

  @override
  List<Object> get props => [autoCompletePlaceList];
}

class GoogleMapPhase2State extends GoogleMapState {
  final String originalString;
  final String? formattedString;
  final double originalLatPosition;
  final double originalLngPosition;
  final double? markLatPosition;
  final double? markLngPosition;

  const GoogleMapPhase2State({required this.originalString,
    this.formattedString,
    required this.originalLatPosition,
    required this.originalLngPosition,
    required this.markLatPosition,
    required this.markLngPosition});

  @override
  List<Object?> get props =>
      [
        originalString,
        formattedString,
        originalLatPosition,
        originalLngPosition,
        markLatPosition,
        markLngPosition
      ];

  GoogleMapPhase2State copyWith({
    String? originalString,
    String? formattedString,
    double? originalLatPosition,
    double? originalLngPosition,
    double? markLatPosition,
    double? markLngPosition,
  }) {
    return GoogleMapPhase2State(
      originalString: originalString ?? this.originalString,
      formattedString: formattedString ?? this.formattedString,
      originalLatPosition: originalLatPosition ?? this.originalLatPosition,
      originalLngPosition: originalLngPosition ?? this.originalLngPosition,
      markLatPosition: markLatPosition ?? this.markLatPosition,
      markLngPosition: markLngPosition ?? this.markLngPosition,
    );
  }
}

class GoogleMapFinished extends GoogleMapState {
  final GeoResultEntity geoResultEntity;

  const GoogleMapFinished({
    required this.geoResultEntity,
  });

  @override
  List<Object> get props => [geoResultEntity];
}

class GoogleMapLoadFailure extends GoogleMapState {
  @override
  List<Object> get props => [];
}
