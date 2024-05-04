import 'package:shopfee/features/choose_address/domain/entities/district_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/provice_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/ward_entity.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:geolocator/geolocator.dart';

abstract class ChooseAddressRepository {
  Future<List<ProvinceEntity>> getListProvince();

  Future<List<DistrictEntity>> getListDistrict(String provinceId);

  Future<List<WardEntity>> getListWard(String districtId);

  Future<Position> getCurrentPosition();

  Future<GeoResultEntity?> getAddressFromPosition(double lat, double lng);

}