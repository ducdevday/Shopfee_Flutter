

import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_list.dart';

abstract class AddressRepositoryBase extends BaseService{
  Future<Result> createAddress(Address address, String userId);
  Future<Result> updateAddress(Address address);
  Future<Result> deleteAddress(String addressId);
  Future<ResultList> getAllAddress(String userId);
  Future<Result> getAddress(String addressId);

}