import 'package:shopfee/features/choose_address/data/models/ward_model.dart';

class WardEntity {
  final String districtId;
  final String wardId;
  final String wardName;
  final String wardType;

  const WardEntity({
    required this.districtId,
    required this.wardId,
    required this.wardName,
    required this.wardType,
  });

  factory WardEntity.fromModel(WardModel model) {
    return WardEntity(
        districtId: model.districtId,
        wardId: model.wardId,
        wardName: model.wardName,
        wardType: model.wardType);
  }
}
