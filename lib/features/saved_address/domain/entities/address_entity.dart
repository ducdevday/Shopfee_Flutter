import 'package:equatable/equatable.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String? detail;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;
  final String? userId;
  final bool? isDefault;

  const AddressEntity({
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

  @override
  List<Object?> get props => [
        id,
        detail,
        latitude,
        longitude,
        note,
        recipientName,
        phoneNumber,
        userId,
        isDefault,
      ];

  factory AddressEntity.fromModel(AddressModel model) {
    return AddressEntity(
      id: model.id,
      detail: model.detail,
      latitude: model.latitude,
      longitude: model.longitude,
      note: model.note,
      recipientName: model.recipientName,
      phoneNumber: model.phoneNumber,
      userId: model.userId,
      isDefault: model.isDefault,
    );
  }
}
