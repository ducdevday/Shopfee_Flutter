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
      String id) async {
    final response =
        await _productByCategoryService.getProductsByCategoryId(id);
    final result = ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    List<ProductInformationModel> productsModel =
        result.data!.map((p) => ProductInformationModel.fromJson(p)).toList();
    List<ProductInformationEntity> productsEntity = productsModel
        .map((p) => ProductInformationEntity.fromModel(p))
        .toList();
    return productsEntity;
  }
}
