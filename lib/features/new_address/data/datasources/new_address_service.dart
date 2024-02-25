import 'package:dio/dio.dart';
import 'package:shopfee/core/base/base_service.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';

class NewAddressService extends BaseService {
  Future<Response> createAddress(AddressModel address, String userId) async {
    Map<String, dynamic> body = {
      "details": address.details,
      "longitude": address.longitude,
      "latitude": address.latitude,
      "note": address.note,
      "recipientName": address.recipientName,
      "phoneNumber": address.phoneNumber
    };
    final response =
        await dio.post("${BaseService.addressPath}/$userId", data: body);
    return response;
  }

  Future<Response> updateAddress(AddressModel address, String userId) async {
    Map<String, dynamic> body = {
      "details": address.details,
      "longitude": address.longitude,
      "latitude": address.latitude,
      "note": address.note,
      "recipientName": address.recipientName,
      "phoneNumber": address.phoneNumber
    };
    final response =
        await dio.put("${BaseService.addressPath}/${address.id}", data: body);

    return response;
  }

  Future<Response> deleteAddress(String addressId) async {
    final response = await dio.delete("${BaseService.addressPath}/$addressId");
    return response;
  }

  Future<Response> getAddress(String addressId) async {
    final response = await dio.get("${BaseService.addressPath}/$addressId");
    return response;
  }
}
