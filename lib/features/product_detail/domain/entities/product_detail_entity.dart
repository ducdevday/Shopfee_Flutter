import 'package:equatable/equatable.dart';
import 'package:shopfee/features/product_detail/data/models/product_detail_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';

class ProductDetailEntity extends Equatable{
  final String? id;
  final String? name;
  final String? imageUrl;
  final List<SizeEntity>? sizeList;
  final String? description;
  final List<ToppingEntity>? toppingList;

  const ProductDetailEntity({
    this.id,
    this.name,
    this.imageUrl,
    this.sizeList,
    this.description,
    this.toppingList,
  });

  factory ProductDetailEntity.fromModel(ProductDetailModel model) {
    return ProductDetailEntity(
        id: model.id,
        name: model.name,
        imageUrl: model.imageUrl,
        sizeList: model.sizeList?.map((s) => SizeEntity.fromModel(s)).toList(),
        description: model.description,
        toppingList:
            model.toppingList?.map((t) => ToppingEntity.fromModel(t)).toList());
  }

  @override
  List<Object?> get props =>
      [id, name, imageUrl, sizeList, description, toppingList];
}
