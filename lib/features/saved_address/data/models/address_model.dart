import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String? id;
  final String? detail;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;
  final String? userId;
  @JsonKey(name: "default")
  final bool? isDefault;

  const AddressModel({
    this.id,
    this.detail,
    this.latitude,
    this.longitude,
    this.note,
    this.recipientName,
    this.phoneNumber,
    this.userId,
    this.isDefault = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return _$AddressModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressModelToJson(this);
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      detail: entity.detail,
      latitude: entity.latitude,
      longitude: entity.longitude,
      note: entity.note,
      recipientName: entity.recipientName,
      phoneNumber: entity.phoneNumber,
      userId: entity.userId,
      isDefault: entity.isDefault,
    );
  }
}
