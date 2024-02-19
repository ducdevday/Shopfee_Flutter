import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/product_detail/data/models/size_model.dart';
import 'package:shopfee/features/product_detail/data/models/topping_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';

part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel {
  final String? id;
  final String? name;
  final String? imageUrl;
  final List<SizeModel>? sizeList;
  final String? description;
  final List<ToppingModel>? toppingList;

  const ProductDetailModel({
    this.id,
    this.name,
    this.imageUrl,
    this.sizeList,
    this.description,
    this.toppingList,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return _$ProductDetailModelFromJson(json);
  }


  Map<String, dynamic> toJson() {
    return _$ProductDetailModelToJson(this);
  }

  factory ProductDetailModel.fromEntity(ProductDetailEntity entity) {
    return ProductDetailModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      sizeList: entity.sizeList?.map((e) => SizeModel.fromEntity(e)).toList(),
      description: entity.description,
      toppingList:
          entity.toppingList?.map((e) => ToppingModel.fromEntity(e)).toList(),
    );
  }
}
