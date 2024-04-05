
import 'package:shopfee/features/coupon_detail/domain/entities/coupon_detail_entity.dart';
import 'package:shopfee/features/coupon_detail/domain/repositories/coupon_detail_repository.dart';

abstract class CouponDetailUseCase{
  Future<CouponDetailEntity> getCouponDetail(String couponId);
}

class CouponDetailUseCaseImpl extends CouponDetailUseCase{
  final CouponDetailRepository _couponRepository;

  CouponDetailUseCaseImpl(this._couponRepository);

  @override
  Future<CouponDetailEntity> getCouponDetail(String couponId) async{
    return await _couponRepository.getCouponDetail(couponId);
  }
}