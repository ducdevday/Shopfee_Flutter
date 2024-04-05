import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';
import 'package:shopfee/features/preferential/domain/repositories/preferential_repository.dart';
import 'package:shopfee/features/template/domain/entities/template_entity.dart';
import 'package:shopfee/features/template/domain/repositories/template_repository.dart';

abstract class PreferentialUseCase {
  Future<List<CouponByTypeEntity>> getTopCoupons(int quantity);
}

class PreferentialUseCaseImpl extends PreferentialUseCase {
  final PreferentialRepository _preferentialRepository;

  PreferentialUseCaseImpl(this._preferentialRepository);

  @override
  Future<List<CouponByTypeEntity>> getTopCoupons(int quantity) async {
    return await _preferentialRepository.getTopCoupons(quantity);
  }
}
