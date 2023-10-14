import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_list.dart';

abstract class ProductRepositoryBase extends BaseService{
  Future<ResultList> getAllProduct();
  Future<Result> getProductById(String id);
  Future<ResultList> getProductsByCategoryId(String id);
}