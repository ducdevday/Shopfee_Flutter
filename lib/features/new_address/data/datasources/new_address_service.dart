import 'package:dio/dio.dart';
import 'package:shopfee/core/base/dio_service.dart';
import 'package:shopfee/features/saved_address/data/models/address_model.dart';

class NewAddressService {
  Future<Response> createAddress(AddressModel address, String userId) async {
    Map<String, dynamic> body = {
      "detail": address.detail,
      "longitude": address.longitude,
      "latitude": address.latitude,
      "note": address.note,
      "recipientName": address.recipientName,
      "phoneNumber": address.phoneNumber
    };
    final response =
        await DioService.instance.post("${DioService.addressPath}/user/$userId", data: body);
    return response;
  }

  Future<Response> updateAddress(AddressModel address) async {
    Map<String, dynamic> body = {
      "detail": address.detail,
      "longitude": address.longitude,
      "latitude": address.latitude,
      "note": address.note,
      "recipientName": address.recipientName,
      "phoneNumber": address.phoneNumber,
      "default": address.isDefault
    };
    final response =
        await DioService.instance.put("${DioService.addressPath}/${address.id}", data: body);

    return response;
  }

  Future<Response> deleteAddress(String addressId) async {
    final response = await DioService.instance.delete("${DioService.addressPath}/$addressId");
    return response;
  }

  Future<Response> getAddress(String addressId) async {
    final response = await DioService.instance.get("${DioService.addressPath}/$addressId");
    return response;
  }
}
