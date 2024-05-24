import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';

abstract class ProductDetailRepository {
  Future<ProductDetailEntity> getProductById(String productId);
  Future<List<ProductInformationEntity>> getViewedProduct(int size);
}