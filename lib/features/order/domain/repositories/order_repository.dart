import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/order/domain/entities/order_query_entity.dart';

abstract class OrderRepository {
  Future<List<ProductInformationEntity>> getProductsByCategoryId(String? id,
      {required int page, required int size, OrderQueryEntity? query});

  Future<List<CategoryEntity>> getAllCategory();
}
