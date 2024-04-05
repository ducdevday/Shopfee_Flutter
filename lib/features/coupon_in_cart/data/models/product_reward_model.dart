import 'package:json_annotation/json_annotation.dart';

part 'product_reward_model.g.dart';

@JsonSerializable()
class ProductRewardModel{
  @JsonKey(name: "productId")
  final String? id;
  @JsonKey(name: "productName")
  final String? name;
  @JsonKey(name: "productSize")
  final String? size;
  final int? quantity;

  const ProductRewardModel({
    this.id,
    this.name,
    this.size,
    this.quantity,
  });

  factory ProductRewardModel.fromJson(Map<String, dynamic> json) {
    return _$ProductRewardModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductRewardModelToJson(this);
  }
}