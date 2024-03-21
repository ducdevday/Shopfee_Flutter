import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/features/home/data/datasource/home_service.dart';
import 'package:shopfee/features/home/data/models/banner_model.dart';
import 'package:shopfee/features/home/data/models/category_model.dart';
import 'package:shopfee/features/home/data/models/product_infomation_model.dart';
import 'package:shopfee/features/home/domain/entities/banner_entity.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeService homeService;

  HomeRepositoryImpl(this.homeService);

  @override
  Future<List<BannerEntity>> getAllBanner() async {
    final response = await homeService.getAllBanner();
    final result = ResultList(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    List<BannerModel> bannersModel =
    result.data!.map((p) => BannerModel.fromJson(p)).toList();
    List<BannerEntity> bannersEntity = bannersModel
        .map((p) => BannerEntity.fromModel(p))
        .toList();
    return bannersEntity;
  }

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

    //Todo Add All In Categories
    categoriesEntity
        .add(CategoryEntity(id: null, name: "All", image: AppPath.imgAll));

    return categoriesEntity;
  }

  @override
  Future<List<ProductInformationEntity>> getOutStandingProduct(
      {required int quantity}) async {
    final response =
        await homeService.getOutStandingProduct(quantity: quantity);
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

  @override
  Future<List<ProductInformationEntity>> getTopSellingProduct(
      {required int quantity}) async {
    final response =
        await homeService.getOutStandingProduct(quantity: quantity);
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
