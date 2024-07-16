import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/repositories/product_detail_repository.dart';

abstract class ProductDetailUseCase {
  Future<ProductDetailEntity> getProductById(String productId);

  Future<List<ProductInformationEntity>> getViewedProduct(int size);

  Future<List<ProductInformationEntity>> getRecommendProduct(String userId, int quantity);
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

  @override
  Future<List<ProductInformationEntity>> getViewedProduct(int size) async {
    return await _productDetailRepository.getViewedProduct(size);
  }

  @override
  Future<List<ProductInformationEntity>> getRecommendProduct(String userId, int quantity) async{
    return await _productDetailRepository.getRecommendProduct(userId, quantity);
  }
}
