import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/coupon_detail/data/models/coupon_detail_model.dart';
import 'package:shopfee/features/coupon_detail/domain/entities/coupon_condition_entity.dart';

class CouponDetailEntity{
  final String? code;
  final CouponType? type;
  final String? description;
  final List<CouponConditionEntity>? conditionList;
  final DateTime? startDate;
  final DateTime? expirationDate;

  const CouponDetailEntity({
    this.code,
    this.type,
    this.description,
    this.conditionList,
    this.startDate,
    this.expirationDate,
  });

  factory CouponDetailEntity.fromModel(CouponDetailModel model) {
    return CouponDetailEntity(
      code: model.code,
      type: model.type,
      description: model.description,
      conditionList: model.conditionList?.map((e) => CouponConditionEntity.fromModel(e)).toList(),
      startDate: model.startDate,
      expirationDate: model.expirationDate,
    );
  }
//
}