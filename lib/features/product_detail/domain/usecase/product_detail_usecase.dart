import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/repositories/product_detail_repository.dart';

import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class ProductDetailUseCase {
  Future<ProductDetailEntity> getProductById(String productId);
}

class ProductDetailUseCaseImpl extends ProductDetailUseCase {
  final ProductDetailRepository _productDetailRepository;

  ProductDetailUseCaseImpl(this._productDetailRepository);

  @override
  Future<ProductDetailEntity> getProductById(String productId) async {
    final product = await _productDetailRepository.getProductById(productId);
    final List<SizeEntity>? sizeList = product.sizeList;
    //Todo: Sort Size Small To Large
    if (sizeList != null) {
      sizeList.sort((a, b) => a.price.compareTo(b.price));
      product.copyWith(sizeList: sizeList);
    }
    return product;
  }
}
