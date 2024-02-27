import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/home/data/datasource/home_service.dart';
import 'package:shopfee/features/home/data/models/category_model.dart';
import 'package:shopfee/features/home/data/models/product_infomation_model.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeService homeService;

  HomeRepositoryImpl(this.homeService);

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    final response = await homeService.getAllCategory();
    final result = ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    List<CategoryModel> categoriesModel =
        result.data!.map((c) => CategoryModel.fromJson(c)).toList();
    List<CategoryEntity> categoriesEntity =
        categoriesModel.map((c) => CategoryEntity.fromModel(c)).toList();
    return categoriesEntity;
  }

  @override
  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity}) async {
    final response =
        await homeService.getOutStandingProduct(quantity: quantity);
    //TODO: Need To Fix
    // final result = ResultList(
    //     success: response.data["success"],
    //     message: response.data["message"],
    //     data: response.data["data"]);
    // List<ProductInformationModel> productsModel =
    //     result.data!.map((p) => ProductInformationModel.fromJson(p)).toList();
    // List<ProductInformationEntity> productsEntity = productsModel
    //     .map((p) => ProductInformationEntity.fromModel(p))
    //     .toList();
    // return productsEntity;

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
