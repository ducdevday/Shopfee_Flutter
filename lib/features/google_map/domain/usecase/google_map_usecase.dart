import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/domain/repositories/google_map_repository.dart';

abstract class GoogleMapUseCase {
  Future<Position> getCurrentPosition();

  Future<GeoResultEntity?> getAddressFromName(String addressString);

  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng);
}

class GoogleMapUseCaseImpl extends GoogleMapUseCase {
  final GoogleMapRepository _googleMapRepository;

  GoogleMapUseCaseImpl(this._googleMapRepository);

  @override
  Future<Position> getCurrentPosition() async {
    return await _googleMapRepository.getCurrentPosition();
  }

  @override
  Future<GeoResultEntity?> getAddressFromName(String addressString) async {
    return await _googleMapRepository.getAddressFromName(addressString);
  }

  @override
  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng) async{
    return await _googleMapRepository.getAddressFromPosition(lat, lng);
  }


}
