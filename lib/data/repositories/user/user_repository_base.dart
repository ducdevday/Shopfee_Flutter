import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/user.dart';

abstract class UserRepositoryBase extends BaseService{
  Future<Result> getUser(String userId);
  Future<Result> updateUser(User user);
  Future<Result> checkEmailExist(String email);
}