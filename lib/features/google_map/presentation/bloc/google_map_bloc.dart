import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/google_map/domain/entities/auto_complete_result_entity.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/domain/usecase/google_map_usecase.dart';

part 'google_map_event.dart';

part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  final GoogleMapUseCase _googleMapUseCase;

  GoogleMapBloc(this._googleMapUseCase) : super(GoogleMapInitial()) {
    on<GoogleMapEnterAddressNoText>(_onGoogleMapEnterAddressNoText);
    on<GoogleMapSelectPlace>(_onGoogleMapSelectPlace);
    // on<GoogleMapLoadInitPosition>(_onGoogleMapLoadInitPosition);
    on<GoogleMapMarkPosition>(_onGoogleMapMarkPosition);
    on<GoogleMapConfirmDone>(_onGoogleMapConfirmDone);
  }

  FutureOr<void> _onGoogleMapEnterAddressNoText(
      GoogleMapEnterAddressNoText event, Emitter<GoogleMapState> emit) async {
    try {
      emit(GoogleMapLoadInProcess());
      final autoCompletePlaceList =
      await _googleMapUseCase.getAutoCompletePlaceList(event.input);
      emit(GoogleMapPhase1State(
        autoCompletePlaceList: autoCompletePlaceList,
      ));
    } catch (e) {
      EasyLoading.dismiss();
      emit(GoogleMapLoadFailure());
    }
  }

  FutureOr<void> _onGoogleMapSelectPlace(GoogleMapSelectPlace event,
      Emitter<GoogleMapState> emit) async {
    try {
      emit(GoogleMapLoadInProcess());
      final GeoResultEntity geoResultEntity = await _googleMapUseCase
          .getAddressFromPlaceId(event.autoCompleteResultEntity.placeId);
      emit(GoogleMapPhase2State(
          originalString: event.autoCompleteResultEntity.description,
          formattedString: geoResultEntity.formattedAddress,
          originalLatPosition: geoResultEntity.lat,
          originalLngPosition: geoResultEntity.lng,
          markLatPosition: null,
          markLngPosition: null));
    } catch (e) {
      EasyLoading.dismiss();
      emit(GoogleMapLoadFailure());
    }
  }

// FutureOr<void> _onGoogleMapLoadInitPosition(
//     GoogleMapLoadInitPosition event, Emitter<GoogleMapState> emit) async {
//   try {
//     EasyLoading.show(maskType: EasyLoadingMaskType.black);
//     Position currentPosition = await _googleMapUseCase.getCurrentPosition();
//     EasyLoading.dismiss();
//     if (event.addressString != null) {
//       EasyLoading.show(maskType: EasyLoadingMaskType.black);
//       GeoResultEntity? geoResultEntity =
//           await _googleMapUseCase.getAddressFromName(event.addressString!);
//       EasyLoading.dismiss();
//       if (geoResultEntity != null) {
//         emit(GoogleMapLoadSuccess(
//             currentLatPosition: geoResultEntity.lat,
//             currentLngPosition: geoResultEntity.lng));
//       } else {
//         EasyLoading.showInfo(
//             "Cannot find chosen address. So get current address instead!");
//         EasyLoading.show(maskType: EasyLoadingMaskType.black);
//         GeoResultEntity? geoResultEntity =
//             await _googleMapUseCase.getAddressFromPosition(
//                 currentPosition.latitude, currentPosition.longitude);
//         EasyLoading.dismiss();
//         emit(GoogleMapLoadSuccess(
//             formattedString: geoResultEntity?.formattedAddress,
//             currentLatPosition: currentPosition.latitude,
//             currentLngPosition: currentPosition.longitude));
//       }
//     } else {
//       EasyLoading.showInfo(
//           "Cannot find chosen address. So get current address instead!");
//       EasyLoading.show(maskType: EasyLoadingMaskType.black);
//       GeoResultEntity? geoResultEntity =
//           await _googleMapUseCase.getAddressFromPosition(
//               currentPosition.latitude, currentPosition.longitude);
//       EasyLoading.dismiss();
//       emit(GoogleMapLoadSuccess(
//           formattedString: geoResultEntity?.formattedAddress,
//           currentLatPosition: currentPosition.latitude,
//           currentLngPosition: currentPosition.longitude));
//     }
//   } catch (e) {
//     EasyLoading.dismiss();
//     emit(GoogleMapLoadFailure());
//   }
// }
//
  FutureOr<void> _onGoogleMapMarkPosition(GoogleMapMarkPosition event,
      Emitter<GoogleMapState> emit) async {
    try {
      if (state is GoogleMapPhase2State) {
        final currentState = state as GoogleMapPhase2State;
        EasyLoading.show();
        GeoResultEntity? geoResultEntity = await _googleMapUseCase
            .getAddressFromPosition(event.latitude, event.longitude);
        EasyLoading.dismiss();
        emit(currentState.copyWith(
            formattedString: geoResultEntity?.formattedAddress,
            markLatPosition: event.latitude,
            markLngPosition: event.longitude));
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(GoogleMapLoadFailure());
    }
  }

  FutureOr<void> _onGoogleMapConfirmDone(GoogleMapConfirmDone event,
      Emitter<GoogleMapState> emit) async {
    try {
      if (state is GoogleMapPhase2State) {
        final currentState = state as GoogleMapPhase2State;
        EasyLoading.show();
        if (currentState.markLatPosition != null &&
            currentState.markLngPosition != null) {
          final isValidMarkPosition = await _googleMapUseCase
              .checkValidMarkPosition(currentState.originalLatPosition,
              currentState.originalLngPosition, currentState.markLatPosition!,
              currentState.markLngPosition!);
          if (!isValidMarkPosition) {
            EasyLoading.showInfo(
                "Current Mark Position Is Far From Current Place Chosen!");
            return;
          }
          emit(GoogleMapFinished(geoResultEntity: GeoResultEntity(
              formattedAddress: currentState.originalString,
              lat: currentState.markLatPosition!,
              lng: currentState.markLngPosition!)));
        }
        else {
          emit(GoogleMapFinished(geoResultEntity: GeoResultEntity(
              formattedAddress: currentState.originalString,
              lat: currentState.originalLatPosition,
              lng: currentState.originalLngPosition)));
        }
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      emit(GoogleMapLoadFailure());
    }
  }
}
