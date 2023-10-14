import 'package:dio/dio.dart';
import 'package:shopfee/data/base/base_service.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/result.dart';
import 'package:shopfee/data/models/result_list.dart';
import 'package:shopfee/data/repositories/address/address_repository_base.dart';

class AddressRepository extends AddressRepositoryBase{
  @override
  Future<Result> createAddress(Address address, String userId) async{
    Map<String, dynamic> body = {
      "details": address.details,
      "longitude": address.longitude,
      "latitude": address.latitude,
      "note": address.note,
      "recipientName": address.recipientName,
      "phoneNumber": address.phoneNumber
    };
    try{
      var response = await dio.post("${BaseService.addressPath}/$userId", data: body);
      print(response.data);
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    }
    catch(e){
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> deleteAddress(String addressId) async {
    try{
      var response = await dio.delete("${BaseService.addressPath}/$addressId");
      print(response.data);
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    }
    catch(e){
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> updateAddress(Address address) async {
    Map<String, dynamic> body = {
      "details": address.details,
      "longitude": address.longitude,
      "latitude": address.latitude,
      "note": address.note,
      "recipientName": address.recipientName,
      "phoneNumber": address.phoneNumber,
      "default":address.isDefault
    };
    try{
      var response = await dio.put("${BaseService.addressPath}/${address.id}", data: body);
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    }
    catch(e){
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }

  @override
  Future<ResultList> getAllAddress(String userId) async{
    try{
      var response = await dio.get("${BaseService.addressPath}/user/$userId");
      return ResultList(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    }
    catch(e){
      print(e);
      if (e is DioError) {
        final response = e.response;
        return ResultList(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return ResultList(success: false, message: e.toString());
    }
  }

  @override
  Future<Result> getAddress(String addressId) async{
    try{
      var response = await dio.get("${BaseService.addressPath}/$addressId");
      return Result(
          success: response.data["success"],
          message: response.data["message"],
          data: response.data["data"]);
    }
    catch(e){
      print(e);
      if (e is DioError) {
        final response = e.response;
        return Result(
            success: response?.data["success"],
            message: response?.data["message"]);
      }
      return Result(success: false, message: e.toString());
    }
  }
}

