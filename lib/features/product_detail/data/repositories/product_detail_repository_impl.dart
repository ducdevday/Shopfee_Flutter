import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/product_detail/data/datasources/product_detail_service.dart';
import 'package:shopfee/features/product_detail/data/models/product_detail_model.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/product_detail/domain/repositories/product_detail_repository.dart';

class ProductDetailRepositoryImpl implements ProductDetailRepository {
  final ProductDetailService _productDetailService;

  ProductDetailRepositoryImpl(this._productDetailService);

  @override
  Future<ProductDetailEntity> getProductById(String productId) async {
    final response = await _productDetailService.getProductById(productId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final productDetailModel = ProductDetailModel.fromJson(result.data!);
    final productDetailEntity =
        ProductDetailEntity.fromModel(productDetailModel);
    return productDetailEntity;
  }
}
