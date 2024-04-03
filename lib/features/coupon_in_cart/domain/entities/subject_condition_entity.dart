
import 'package:shopfee/features/coupon_in_cart/data/models/subject_condition_model.dart';

class SubjectConditionEntity {
  final String productName;
  final num value;

  const SubjectConditionEntity({
    required this.productName,
    required this.value,
  });

  factory SubjectConditionEntity.fromModel(SubjectConditionModel model) {
    return SubjectConditionEntity(
      productName: model.productName,
      value: model.value,
    );
  }
}
