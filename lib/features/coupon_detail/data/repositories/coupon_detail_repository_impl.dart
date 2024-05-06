import 'package:shopfee/core/common/models/result.dart';
import 'package:shopfee/features/coupon_detail/data/datasources/coupon_detail_service.dart';
import 'package:shopfee/features/coupon_detail/data/models/coupon_detail_model.dart';
import 'package:shopfee/features/coupon_detail/domain/entities/coupon_detail_entity.dart';
import 'package:shopfee/features/coupon_detail/domain/repositories/coupon_detail_repository.dart';

class CouponDetailRepositoryImpl implements CouponDetailRepository {
  final CouponDetailService _couponDetailService;

  CouponDetailRepositoryImpl(this._couponDetailService);

  @override
  Future<CouponDetailEntity> getCouponDetail(String couponId) async{
    final response = await _couponDetailService.getCouponDetail(couponId);
    final result = Result(
      success: response.data["success"],
      message: response.data["message"],
      data: response.data["data"],
    );
    final couponDetailModel = CouponDetailModel.fromJson(result.data!);
    final couponDetailEntity = CouponDetailEntity.fromModel(couponDetailModel);
    return couponDetailEntity;
  }
}
