import 'package:shopfee/features/home/data/models/product_infomation_model.dart';

class ProductInformationEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const ProductInformationEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductInformationEntity.fromModel(ProductInformationModel model) {
    return ProductInformationEntity(
        id: model.id!,
        name: model.name!,
        description: model.description!,
        price: model.price!,
        imageUrl: model.imageUrl!);
  }
}
