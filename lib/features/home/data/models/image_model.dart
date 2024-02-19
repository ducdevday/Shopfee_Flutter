import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final String? id;
  final String? url;

  ImageModel({this.id, this.url});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return _$ImageModelFromJson(json);
  }
}
