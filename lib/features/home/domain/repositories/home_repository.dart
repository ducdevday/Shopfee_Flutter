import 'package:shopfee/features/home/domain/entities/banner_entity.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';

abstract class HomeRepository {
  Future<List<BannerEntity>> getAllBanner();

  Future<List<CategoryEntity>> getAllCategory();

  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity});

  Future<List<ProductInformationEntity>> getTopSellingProduct(
      {required int quantity});

}
