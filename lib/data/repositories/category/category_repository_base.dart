import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';

abstract class CategoryRepositoryBase extends BaseService{
  Future<Result> getAllCategory();

}
