import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/home/data/models/product_infomation_model.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/product_by_category/data/datasources/product_by_category_service.dart';
import 'package:shopfee/features/product_by_category/domain/repositories/product_by_category_repository.dart';

class ProductByCategoryRepositoryImpl implements ProductByCategoryRepository {
  final ProductByCategoryService _productByCategoryService;

  ProductByCategoryRepositoryImpl(this._productByCategoryService);

  @override
  Future<List<ProductInformationEntity>> getProductsByCategoryId(
      String? id, {required int page, required int size}) async {
    final response =
        await _productByCategoryService.getProductsByCategoryId(id, page: page, size: size);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final List<dynamic> productList = result.data!["productList"] as List<dynamic>;
    List<ProductInformationModel> productsModel =
    productList.map((p) => ProductInformationModel.fromJson(p)).toList();
    List<ProductInformationEntity> productsEntity = productsModel
        .map((p) => ProductInformationEntity.fromModel(p))
        .toList();
    return productsEntity;
  }
}
