import 'package:shopfee/features/choose_address/domain/entities/district_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/provice_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/ward_entity.dart';

abstract class ChooseAddressRepository {
  Future<List<ProvinceEntity>> getListProvince();

  Future<List<DistrictEntity>> getListDistrict(String provinceId);

  Future<List<WardEntity>> getListWard(String districtId);
}