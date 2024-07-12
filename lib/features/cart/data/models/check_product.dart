
import 'package:json_annotation/json_annotation.dart';

part 'check_product.g.dart';

@JsonSerializable()
class CheckProduct{
  final String productId;

  const CheckProduct({
    required this.productId,
  });

  factory CheckProduct.fromJson(Map<String, dynamic> json) {
    return _$CheckProductFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckProductToJson(this);
  }
}