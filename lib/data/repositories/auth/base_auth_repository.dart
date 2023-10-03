import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/user.dart';

abstract class BaseAuthRepository extends BaseService{
  Future<bool> register(User user);
}