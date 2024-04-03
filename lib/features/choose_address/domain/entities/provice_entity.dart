import 'package:shopfee/features/choose_address/data/models/province_model.dart';

class ProvinceEntity {
  final String? provinceId;
  final String? provinceName;
  final String? provinceType;

  const ProvinceEntity({
    this.provinceId,
    this.provinceName,
    this.provinceType,
  });

  factory ProvinceEntity.fromModel(ProvinceModel model) {
    return ProvinceEntity(
        provinceId: model.provinceId,
        provinceName: model.provinceName,
        provinceType: model.provinceType);
  }
}
