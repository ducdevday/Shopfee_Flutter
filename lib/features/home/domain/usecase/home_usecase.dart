import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/domain/repositories/home_repository.dart';

abstract class HomeUseCase {
  Future<List<CategoryEntity>> getAllCategory();

  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity});
}

class HomeUseCaseImpl extends HomeUseCase {
  final HomeRepository _homeRepository;

  HomeUseCaseImpl(this._homeRepository);

  @override
  Future<List<CategoryEntity>> getAllCategory() {
    return _homeRepository.getAllCategory();
  }

  @override
  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity}) {
    return _homeRepository.getOutStandingProduct(quantity: quantity);
  }
}
