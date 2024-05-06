import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/preferential/data/datasources/preferential_service.dart';
import 'package:shopfee/features/preferential/data/models/coupon_by_type_model.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';
import 'package:shopfee/features/preferential/domain/repositories/preferential_repository.dart';

class PreferentialRepositoryImpl implements PreferentialRepository {
  final PreferentialService _preferentialService;

  PreferentialRepositoryImpl(this._preferentialService);

  @override
  Future<List<CouponByTypeEntity>> getTopCoupons(int quantity) async {
    final response = await _preferentialService.getTopCoupons(quantity);
    final resultList = ResultList(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    List<CouponByTypeModel> couponByTypeModel =
        resultList.data!.map((c) => CouponByTypeModel.fromJson(c)).toList();
    List<CouponByTypeEntity> couponByTypeEntity =
        couponByTypeModel.map((c) => CouponByTypeEntity.fromModel(c)).toList();
    return couponByTypeEntity;
  }
}
