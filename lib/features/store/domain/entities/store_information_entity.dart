import 'package:shopfee/features/store/data/models/store_information_model.dart';

class StoreInformationEntity {
  final String? id;
  final String? imageUrl;
  final String? name;
  final String? fullAddress;
  final double? longitude;
  final double? latitude;
  final String? distance;
  final bool? isValid;

  const StoreInformationEntity({
    this.id,
    this.imageUrl,
    this.name,
    this.fullAddress,
    this.longitude,
    this.latitude,
    this.distance,
    this.isValid,
  });

  factory StoreInformationEntity.fromModel(StoreInformationModel model) {
    return StoreInformationEntity(
      id: model.id,
      imageUrl: model.imageUrl,
      name: model.name,
      fullAddress: model.fullAddress,
      longitude: model.longitude,
      latitude: model.latitude,
      distance: model.distance,
      isValid: model.isValid,
    );
  }
}
