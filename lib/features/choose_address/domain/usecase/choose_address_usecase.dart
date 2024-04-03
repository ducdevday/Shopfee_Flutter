import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/choose_address/domain/entities/district_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/provice_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/ward_entity.dart';
import 'package:shopfee/features/choose_address/domain/repositories/choose_address_repository.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class ChooseAddressUseCase {
  Future<List<ProvinceEntity>> getListProvince();

  Future<List<DistrictEntity>> getListDistrict(String provinceId);

  Future<List<WardEntity>> getListWard(String districtId);
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
}
