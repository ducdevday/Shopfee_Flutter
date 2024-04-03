import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  final String imageUrl;

  const BannerModel({
    required this.imageUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return _$BannerModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BannerModelToJson(this);
  }
}
