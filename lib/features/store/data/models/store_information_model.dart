import 'package:json_annotation/json_annotation.dart';

part 'store_information_model.g.dart';

@JsonSerializable()
class StoreInformationModel {
  final int? id;
  final String? imageUrl;
  final String? name;
  final String? fullAddress;
  final double? longitude;
  final double? latitude;
  final String? distance;
  final bool? isValid;

  const StoreInformationModel({
    this.id,
    this.imageUrl,
    this.name,
    this.fullAddress,
    this.longitude,
    this.latitude,
    this.distance,
    this.isValid,
  });

  factory StoreInformationModel.fromJson(Map<String, dynamic> json) {
    return _$StoreInformationModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StoreInformationModelToJson(this);
  }
}
