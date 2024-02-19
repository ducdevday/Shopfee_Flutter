import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';

part 'topping_model.g.dart';

@JsonSerializable()
class ToppingModel {
  final String? name;
  final double? price;

  ToppingModel({required this.name, required this.price});

  factory ToppingModel.fromJson(Map<String, dynamic> json) {
    return _$ToppingModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ToppingModelToJson(this);
  }

  factory ToppingModel.fromEntity(ToppingEntity entity) {
    return ToppingModel(name: entity.name, price: entity.price);
  }
}
