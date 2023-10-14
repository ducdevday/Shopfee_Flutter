import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result_list.dart';

abstract class CategoryRepositoryBase extends BaseService{
  Future<ResultList> getAllCategory();

}
