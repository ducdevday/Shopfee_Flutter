import 'package:shopfee/features/blog/domain/entities/blog_information_entity.dart';
import 'package:shopfee/features/home/domain/entities/banner_entity.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/domain/repositories/home_repository.dart';

abstract class HomeUseCase {
  Future<List<BannerEntity>> getAllBanner();

  Future<List<CategoryEntity>> getAllCategory();

  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity});

  Future<List<ProductInformationEntity>> getTopSellingProduct(
      {required int quantity});

  Future<List<ProductInformationEntity>> getViewedProduct(
      {required int quantity});

  Future<List<BlogInformationEntity>> getNewestBlog({required int quantity});
}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);

  @override
  Future<List<BannerEntity>> getAllBanner() async {
    return await _homeRepository.getAllBanner();
  }

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    return await _homeRepository.getAllCategory();
  }

  @override
  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity}) async {
    return await _homeRepository.getOutStandingProduct(quantity: quantity);
  }

  @override
  Future<List<ProductInformationEntity>> getTopSellingProduct(
      {required int quantity}) async {
    return await _homeRepository.getTopSellingProduct(quantity: quantity);
  }

  @override
  Future<List<ProductInformationEntity>> getViewedProduct(
      {required int quantity}) async {
    return await _homeRepository.getViewedProduct(quantity: quantity);
  }

  @override
  Future<List<BlogInformationEntity>> getNewestBlog(
      {required int quantity}) async {
    return await _homeRepository.getNewestBlog(quantity: quantity);
  }
}
