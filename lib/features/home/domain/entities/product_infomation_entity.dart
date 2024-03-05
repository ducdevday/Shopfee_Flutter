import 'package:shopfee/core/common/enum/product_status.dart';
import 'package:shopfee/features/home/data/models/product_infomation_model.dart';
import 'package:shopfee/features/home/domain/entities/rating_summary_entity.dart';

class ProductInformationEntity {
  final String? id;
  final String? name;
  final String? description;
  final double? price;
  final String? imageUrl;
  final ProductStatus? status;
  final RatingSummaryEntity? ratingSummary;

  const ProductInformationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.status,
    required this.ratingSummary,
  });

  factory ProductInformationEntity.fromModel(ProductInformationModel model) {
    return ProductInformationEntity(
        id: model.id,
        name: model.name,
        description: model.description,
        price: model.price,
        imageUrl: model.imageUrl,
        status: model.status,
        ratingSummary:model.ratingSummary == null ? null : RatingSummaryEntity.fromModel(model.ratingSummary!));
  }
}
