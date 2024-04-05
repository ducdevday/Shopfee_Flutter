import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/common/models/result_list.dart';
import 'package:shopfee/features/coupon/data/datasources/coupon_service.dart';
import 'package:shopfee/features/coupon/domain/repositories/coupon_repository.dart';
import 'package:shopfee/features/preferential/data/models/coupon_by_type_model.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';

class CouponRepositoryImpl implements CouponRepository {
  final CouponService _couponService;

  CouponRepositoryImpl(this._couponService);

  @override
  Future<List<CouponByTypeEntity>> getCouponsByType(CouponType type) async{
    final response = await _couponService.getCouponsByType(type);
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
