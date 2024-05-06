import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon/domain/repositories/coupon_repository.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';

abstract class CouponUseCase {
  Future<List<CouponByTypeEntity>> getCouponsByType(CouponType type);
}

class CouponUseCaseImpl extends CouponUseCase {
  final CouponRepository _couponRepository;

  CouponUseCaseImpl(this._couponRepository);

  @override
  Future<List<CouponByTypeEntity>> getCouponsByType(CouponType type) async {
    return await _couponRepository.getCouponsByType(type);
  }
}
