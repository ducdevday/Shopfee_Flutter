import 'package:equatable/equatable.dart';
import 'package:shopfee/core/common/enum/product_status.dart';
import 'package:shopfee/features/home/domain/entities/rating_summary_entity.dart';
import 'package:shopfee/features/product_detail/data/models/product_detail_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';

class ProductDetailEntity extends Equatable {
  final String? id;
  final String? name;
  final String? imageUrl;
  final List<SizeEntity>? sizeList;
  final String? description;
  final List<ToppingEntity>? toppingList;
  final ProductStatus? status;
  final RatingSummaryEntity? ratingSummary;

  const ProductDetailEntity(
      {this.id,
      this.name,
      this.imageUrl,
      this.sizeList,
      this.description,
      this.toppingList,
      this.status,
      this.ratingSummary});

  factory ProductDetailEntity.fromModel(ProductDetailModel model) {
    return ProductDetailEntity(
        id: model.id,
        name: model.name,
        imageUrl: model.imageUrl,
        sizeList: model.sizeList?.map((s) => SizeEntity.fromModel(s)).toList(),
        description: model.description,
        toppingList:
            model.toppingList?.map((t) => ToppingEntity.fromModel(t)).toList(),
        status: model.status,
        ratingSummary: model.ratingSummary == null
            ? null
            : RatingSummaryEntity.fromModel(model.ratingSummary!));
  }



  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        sizeList,
        description,
        toppingList,
        status,
        ratingSummary,
      ];

  ProductDetailEntity copyWith({
    String? id,
    String? name,
    String? imageUrl,
    List<SizeEntity>? sizeList,
    String? description,
    List<ToppingEntity>? toppingList,
    ProductStatus? status,
    RatingSummaryEntity? ratingSummary,
  }) {
    return ProductDetailEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      sizeList: sizeList ?? this.sizeList,
      description: description ?? this.description,
      toppingList: toppingList ?? this.toppingList,
      status: status ?? this.status,
      ratingSummary: ratingSummary ?? this.ratingSummary,
    );
  }
}
