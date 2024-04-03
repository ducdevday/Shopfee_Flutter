
import 'package:json_annotation/json_annotation.dart';

part 'user_google_model.g.dart';

@JsonSerializable()
class UserGoogleModel {
  final String? id;
  final String? email;
  final String? displayName;

  const UserGoogleModel({
    required this.id,
    required this.email,
    required this.displayName,
  });

  factory UserGoogleModel.fromJson(Map<String, dynamic> json) {
    return _$UserGoogleModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserGoogleModelToJson(this);
  }

}
