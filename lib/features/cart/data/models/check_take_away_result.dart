
import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/features/cart/data/models/check_product.dart';


part 'check_take_away_result.g.dart';

@JsonSerializable()
class CheckTakeAwayResult{
  final List<CheckProduct> orderItemInvalidList;

  const CheckTakeAwayResult({
    required this.orderItemInvalidList,
  });

  factory CheckTakeAwayResult.fromJson(Map<String, dynamic> json) {
    return _$CheckTakeAwayResultFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CheckTakeAwayResultToJson(this);
  }
}