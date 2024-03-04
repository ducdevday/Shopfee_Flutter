import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/product_by_category/domain/repositories/product_by_category_repository.dart';

abstract class ProductByCategoryUseCase {
  Future<List<ProductInformationEntity>> getProductsByCategoryId(String? id,
      {required int page, required int size});
}

class ProductByCategoryUseCaseImpl extends ProductByCategoryUseCase {
  final ProductByCategoryRepository _productByCategoryRepository;

  ProductByCategoryUseCaseImpl(this._productByCategoryRepository);

  @override
  Future<List<ProductInformationEntity>> getProductsByCategoryId(String? id,
      {required int page, required int size}) async {
    return await _productByCategoryRepository.getProductsByCategoryId(id,
        page: page, size: size);
  }
}
