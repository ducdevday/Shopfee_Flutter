import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/domain/repositories/home_repository.dart';

abstract class HomeUseCase {
  Future<List<CategoryEntity>> getAllCategory();

  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity});

  Future<List<ProductInformationEntity>> getTopSellingProduct(
      {required int quantity});
}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);

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
}
