import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String? id;
  final String? details;
  final double? latitude;
  final double? longitude;
  final String? note;
  final String? recipientName;
  final String? phoneNumber;
  final String? userId;
  final bool? isDefault;

  const Address({
    this.id,
    this.details,
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
        details,
        latitude,
        longitude,
        note,
        recipientName,
        phoneNumber,
        userId,
        isDefault,
      ];

  @override
  String toString() {
    return 'Address{' +
        ' id: $id,' +
        ' details: $details,' +
        ' latitude: $latitude,' +
        ' longitude: $longitude,' +
        ' note: $note,' +
        ' recipientName: $recipientName,' +
        ' phoneNumber: $phoneNumber,' +
        ' userId: $userId,' +
        ' isDefault: $isDefault,' +
        '}';
  }

  Address copyWith({
    String? id,
    String? details,
    double? latitude,
    double? longitude,
    String? note,
    String? recipientName,
    String? phoneNumber,
    String? userId,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      details: details ?? this.details,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      note: note ?? this.note,
      recipientName: recipientName ?? this.recipientName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'details': this.details,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'note': this.note,
      'recipientName': this.recipientName,
      'phoneNumber': this.phoneNumber,
      'userId': this.userId,
      'isDefault': this.isDefault,
    };
  }
  Map<String, dynamic> toMapOrder() {
    return {
      'details': this.details,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'note': this.note,
      'recipientName': this.recipientName,
      'phoneNumber': this.phoneNumber,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
      return Address(
        id: map['id'] as String,
        details: map['details'] as String,
        recipientName: map['recipientName'] as String,
        phoneNumber: map['phoneNumber'] as String,
        isDefault: map['default'] as bool,
      );
  }
  factory Address.fromMapFull(Map<String, dynamic> map) {
    return Address(
      id: map["id"] as String,
      details: map["details"] as String,
      latitude: map["latitude"] as double,
      longitude: map["longitude"] as double,
      note: map["note"] as String,
      recipientName: map["recipientName"] as String,
      phoneNumber: map["phoneNumber"] as String,
      isDefault: map["default"] as bool,);
  }


  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      details: json["details"],
      latitude: json["latitude"] as double?,
      longitude: json["longitude"] as double?,
      note: json["note"],
      recipientName: json["recipientName"],
      phoneNumber: json["phoneNumber"],
      userId: json["userId"],
      isDefault: json["isDefault"] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "details": this.details,
      "latitude": this.latitude,
      "longitude": this.longitude,
      "note": this.note,
      "recipientName": this.recipientName,
      "phoneNumber": this.phoneNumber,
      "userId": this.userId,
      "isDefault": this.isDefault,
    };
  }
}
