import 'package:geolocator/geolocator.dart';
import 'package:shopfee/features/choose_address/domain/entities/district_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/provice_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/ward_entity.dart';
import 'package:shopfee/features/choose_address/domain/repositories/choose_address_repository.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';

abstract class ChooseAddressUseCase {
  Future<List<ProvinceEntity>> getListProvince();

  Future<List<DistrictEntity>> getListDistrict(String provinceId);

  Future<List<WardEntity>> getListWard(String districtId);

  Future<Position> getCurrentPosition();

  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng);

}

class ChooseAddressUseCaseImpl extends ChooseAddressUseCase {
  final ChooseAddressRepository _chooseAddressRepository;

  ChooseAddressUseCaseImpl(this._chooseAddressRepository);

  @override
  Future<List<ProvinceEntity>> getListProvince() async {
    return await _chooseAddressRepository.getListProvince();
  }

  @override
  Future<List<DistrictEntity>> getListDistrict(String provinceId) async {
    return await _chooseAddressRepository.getListDistrict(provinceId);
  }

  @override
  Future<List<WardEntity>> getListWard(String districtId) async {
    return await _chooseAddressRepository.getListWard(districtId);
  }

  @override
  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng) async{
    return await _chooseAddressRepository.getAddressFromPosition(lat, lng);
  }

  @override
  Future<Position> getCurrentPosition() async{
    return await _chooseAddressRepository.getCurrentPosition();
  }
}
