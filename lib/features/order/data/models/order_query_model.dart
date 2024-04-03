import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/product_sort_type.dart';
import 'package:shopfee/features/order/domain/entities/order_query_entity.dart';

part 'order_query_model.g.dart';

@JsonSerializable()
class OrderQueryModel {
  @JsonKey(name: "min_price")
  final num? minPrice;
  @JsonKey(name: "max_price")
  final num? maxPrice;
  @JsonKey(name: "min_star")
  final num? minStar;
  @JsonKey(name: "sort_type")
  final ProductSortType? sortType;

  OrderQueryModel(this.minPrice, this.maxPrice, this.minStar, this.sortType);

  factory OrderQueryModel.fromJson(Map<String, dynamic> json) {
    return _$OrderQueryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderQueryModelToJson(this);
  }

  factory OrderQueryModel.fromEntity(OrderQueryEntity entity) {
    return OrderQueryModel(
        entity.minPrice, entity.maxPrice, entity.minStar, entity.sortType);
  }
}
