import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';

abstract class ProductDetailRepository {
  Future<ProductDetailEntity> getProductById(String productId);
}