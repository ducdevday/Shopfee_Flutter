import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:shopfee/features/choose_address/data/datasources/choose_address_service.dart';
import 'package:shopfee/features/choose_address/data/models/district_model.dart';
import 'package:shopfee/features/choose_address/data/models/province_model.dart';
import 'package:shopfee/features/choose_address/data/models/ward_model.dart';
import 'package:shopfee/features/choose_address/domain/entities/district_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/provice_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/ward_entity.dart';
import 'package:shopfee/features/choose_address/domain/repositories/choose_address_repository.dart';
import 'package:shopfee/features/google_map/data/models/geo_result_model.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';

class ChooseAddressRepositoryImpl implements ChooseAddressRepository {
  final ChooseAddressService _chooseAddressService;

  ChooseAddressRepositoryImpl(this._chooseAddressService);

  @override
  Future<List<ProvinceEntity>> getListProvince() async {
    final response = await _chooseAddressService.getListProvince();
    final resultList = response.data["results"] as List<dynamic>;
    final provinceModelList =
        resultList.map((e) => ProvinceModel.fromJson(e)).toList();
    final provinceEntityList =
        provinceModelList.map((e) => ProvinceEntity.fromModel(e)).toList();
    return provinceEntityList;
  }

  @override
  Future<List<DistrictEntity>> getListDistrict(String provinceId) async {
    final response = await _chooseAddressService.getListDistrict(provinceId);
    final resultList = response.data["results"] as List<dynamic>;
    final districtModelList =
        resultList.map((e) => DistrictModel.fromJson(e)).toList();
    final districtEntityList =
        districtModelList.map((e) => DistrictEntity.fromModel(e)).toList();
    return districtEntityList;
  }

  @override
  Future<List<WardEntity>> getListWard(String districtId) async {
    final response = await _chooseAddressService.getListWard(districtId);
    final resultList = response.data["results"] as List<dynamic>;
    final wardModelList = resultList.map((e) => WardModel.fromJson(e)).toList();
    final wardEntityList =
        wardModelList.map((e) => WardEntity.fromModel(e)).toList();
    return wardEntityList;
  }

  @override
  Future<GeoResultEntity?> getAddressFromPosition(
      double lat, double lng) async {
    try {
      final response = await _chooseAddressService.getAddressFromPosition(lat, lng);
      final result = response.data['results'] as List<dynamic>?;
      // ? Lấy kết quả đầu tiên
      if (result != null && result.isNotEmpty) {
        final GeoResultModel geoResultModel =
        GeoResultModel.fromJson(result[0]);
        final GeoResultEntity geoResultEntity =
        GeoResultEntity.fromModel(geoResultModel);
        return geoResultEntity;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Position> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
