import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/features/home/data/models/category_model.dart';
import 'package:shopfee/features/home/data/models/product_infomation_model.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/order/data/datasources/order_service.dart';
import 'package:shopfee/features/order/data/models/order_query_model.dart';
import 'package:shopfee/features/order/domain/entities/order_query_entity.dart';
import 'package:shopfee/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderService _orderService;

  OrderRepositoryImpl(this._orderService);

  @override
  Future<List<ProductInformationEntity>> getProductsByCategoryId(String? id,
      {required int page, required int size, OrderQueryEntity? query}) async {
    final response = await _orderService.getProductsByCategoryId(id,
        page: page,
        size: size,
        query: query == null ? null : OrderQueryModel.fromEntity(query));
    final result = Result(
        success: response.data["success"],
        message: response.data["message"],
        data: response.data["data"]);
    final List<dynamic> productList =
        result.data!["productList"] as List<dynamic>;
    List<ProductInformationModel> productsModel =
        productList.map((p) => ProductInformationModel.fromJson(p)).toList();
    List<ProductInformationEntity> productsEntity = productsModel
        .map((p) => ProductInformationEntity.fromModel(p))
        .toList();
    return productsEntity;
  }

  @override
  Future<List<CategoryEntity>> getAllCategory() async {
    final response = await _orderService.getAllCategory();
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
}
