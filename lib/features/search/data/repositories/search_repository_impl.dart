import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/home/data/models/product_infomation_model.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/search/data/datasources/search_service.dart';
import 'package:shopfee/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchService _searchService;

  SearchRepositoryImpl(this._searchService);

  @override
  Future<List<ProductInformationEntity>> getSearchProduct(
      String searchString, int page, int size) async {
    final response =
        await _searchService.getSearchProduct(searchString, page, size);
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    List<dynamic> productList = result.data!["productList"] as List<dynamic>;
    List<ProductInformationModel> productsModel =
    productList.map((p) => ProductInformationModel.fromJson(p)).toList();
    List<ProductInformationEntity> productsEntity = productsModel
        .map((p) => ProductInformationEntity.fromModel(p))
        .toList();
    return productsEntity;
  }
}
