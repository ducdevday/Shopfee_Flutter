import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/domain/usecase/google_map_usecase.dart';

part 'google_map_event.dart';

part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  final GoogleMapUseCase _googleMapUseCase;

  GoogleMapBloc(this._googleMapUseCase) : super(GoogleMapInitial()) {
    on<GoogleMapLoadInitPosition>(_onGoogleMapLoadInitPosition);
    on<GoogleMapMarkPosition>(_onGoogleMapMarkPosition);
  }

  FutureOr<void> _onGoogleMapLoadInitPosition(
      GoogleMapLoadInitPosition event, Emitter<GoogleMapState> emit) async {
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      Position currentPosition = await _googleMapUseCase.getCurrentPosition();
      EasyLoading.dismiss();
      if (event.addressString != null) {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        GeoResultEntity? geoResultEntity =
            await _googleMapUseCase.getAddressFromName(event.addressString!);
        EasyLoading.dismiss();
        if (geoResultEntity != null) {
          emit(GoogleMapLoadSuccess(
              currentLatPosition: geoResultEntity.lat,
              currentLngPosition: geoResultEntity.lng));
        }
        else{
          EasyLoading.showInfo(
              "Cannot find chosen address. So get current address instead!");
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
          GeoResultEntity? geoResultEntity =
          await _googleMapUseCase.getAddressFromPosition(
              currentPosition.latitude, currentPosition.longitude);
          EasyLoading.dismiss();
          emit(GoogleMapLoadSuccess(
              formattedString: geoResultEntity?.formattedAddress,
              currentLatPosition: currentPosition.latitude,
              currentLngPosition: currentPosition.longitude));
        }
      } else {
        EasyLoading.showInfo(
            "Cannot find chosen address. So get current address instead!");
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        GeoResultEntity? geoResultEntity =
            await _googleMapUseCase.getAddressFromPosition(
                currentPosition.latitude, currentPosition.longitude);
        EasyLoading.dismiss();
        emit(GoogleMapLoadSuccess(
            formattedString: geoResultEntity?.formattedAddress,
            currentLatPosition: currentPosition.latitude,
            currentLngPosition: currentPosition.longitude));
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(GoogleMapLoadFailure());
    }
  }

  FutureOr<void> _onGoogleMapMarkPosition(
      GoogleMapMarkPosition event, Emitter<GoogleMapState> emit) async {
    try {
      if (state is GoogleMapLoadSuccess) {
        final currentState = state as GoogleMapLoadSuccess;
        if (currentState.formattedString != null) {
          EasyLoading.show();
          GeoResultEntity? geoResultEntity = await _googleMapUseCase
              .getAddressFromPosition(event.latitude, event.longitude);
          EasyLoading.dismiss();
          emit(GoogleMapLoadSuccess(
              formattedString: geoResultEntity?.formattedAddress,
              currentLatPosition: event.latitude,
              currentLngPosition: event.longitude));
        } else {
          emit(GoogleMapLoadSuccess(
              currentLatPosition: event.latitude,
              currentLngPosition: event.longitude));
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(GoogleMapLoadFailure());
    }
  }
}
