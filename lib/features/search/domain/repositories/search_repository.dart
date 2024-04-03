import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';

abstract class SearchRepository {
  Future<List<ProductInformationEntity>> getSearchProduct(String searchString, int page, int size);
}