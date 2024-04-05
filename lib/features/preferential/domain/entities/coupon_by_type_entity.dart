import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/features/preferential/data/models/coupon_by_type_model.dart';

class CouponByTypeEntity {
  final String? id;
  final String? description;
  final DateTime? startDate;
  final DateTime? expirationDate;
  final CouponType? type;

  const CouponByTypeEntity({
    this.id,
    this.description,
    this.startDate,
    this.expirationDate,
    this.type,
  });

  factory CouponByTypeEntity.fromModel(CouponByTypeModel model) {
    return CouponByTypeEntity(
      id: model.id,
      description: model.description,
      startDate: model.startDate,
      expirationDate: model.expirationDate,
      type: model.type,
    );
  }
}
