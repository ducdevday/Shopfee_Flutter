import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_repository.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository geolocationRepository;
  GeolocationBloc({required this.geolocationRepository}) : super(GeolocationInitial()) {
    on<LoadGeolocation>(_loadGeolocation);
    on<UpdateGeolocation>(_updateGeolocation);
  }

  FutureOr<void> _loadGeolocation(LoadGeolocation event, Emitter<GeolocationState> emit) async {
    Position position = await geolocationRepository.getCurrentLocation();
    add(UpdateGeolocation(position: position));
  }

  FutureOr<void> _updateGeolocation(UpdateGeolocation event, Emitter<GeolocationState> emit) {
    emit(GeolocationLoaded(position: event.position));
  }
}
