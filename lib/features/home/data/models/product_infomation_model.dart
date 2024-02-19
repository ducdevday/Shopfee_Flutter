import 'package:json_annotation/json_annotation.dart';

part 'product_infomation_model.g.dart';

@JsonSerializable()
class ProductInformationModel  {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  @JsonKey(name: "thumbnailUrl")
  final String? imageUrl;

  const ProductInformationModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductInformationModel.fromJson(Map<String, dynamic> json) {
    return _$ProductInformationModelFromJson(json);
  }
}