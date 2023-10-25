import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopfee/data/models/place_search.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_repository.dart';
import 'package:shopfee/data/repositories/place/place_repository.dart';

part 'geolocation_event.dart';

part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository geolocationRepository;
  final PlaceRepository placeRepository;

  GeolocationBloc({
    required this.geolocationRepository,
    required this.placeRepository,
  }) : super(GeolocationInitial()) {
    on<LoadGeolocation>(_onLoadGeolocation);
    on<UpdateGeolocation>(_onUpdateGeolocation);
    on<SearchPlace>(_onSearchPlace);
    on<ChoosePlace>(_onChoosePlace);
  }

  FutureOr<void> _onLoadGeolocation(
      LoadGeolocation event, Emitter<GeolocationState> emit) async {
    EasyLoading.show();
    Position position = await geolocationRepository.getCurrentLocation();
    EasyLoading.dismiss();
    add(UpdateGeolocation(position: position));
  }

  FutureOr<void> _onUpdateGeolocation(
      UpdateGeolocation event, Emitter<GeolocationState> emit) async {
    EasyLoading.show();
    final List<PlaceSearch>? placeSearchList = await placeRepository
        .getAllPlaceDefault(event.position.latitude, event.position.longitude);
    EasyLoading.dismiss();
    emit(GeolocationLoaded(
        position: event.position, placeSearchList: placeSearchList!));
  }

  FutureOr<void> _onSearchPlace(
      SearchPlace event, Emitter<GeolocationState> emit) async {
    if (state is GeolocationLoaded) {
      final currentState = state as GeolocationLoaded;
      if (event.queryString.isNotEmpty) {
        final List<PlaceSearch>? placeSearchList =
            await placeRepository.getAllPlaceSearch(event.queryString);
        emit(currentState.copyWith(placeSearchList: placeSearchList));
      }
    }
  }

  FutureOr<void> _onChoosePlace(
      ChoosePlace event, Emitter<GeolocationState> emit) {
    if (state is GeolocationLoaded) {
      final currentState = state as GeolocationLoaded;
      emit(currentState.copyWith(
          placeSearchChoose: event.placeSearchChoose, placeSearchList: []));
    }
  }
}
