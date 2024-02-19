import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';

abstract class ProductByCategoryRepository {
  Future<List<ProductInformationEntity>> getProductsByCategoryId(String id);
}