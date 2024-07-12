import 'package:json_annotation/json_annotation.dart';
import 'package:shopfee/core/common/enum/product_sort_type.dart';
import 'package:shopfee/features/search/domain/entities/search_query_entity.dart';

part 'search_query_model.g.dart';

@JsonSerializable()
class SearchQueryModel {
  @JsonKey(name: "branch_id")
  final String? branchId;
  @JsonKey(name: "min_price")
  final num? minPrice;
  @JsonKey(name: "max_price")
  final num? maxPrice;
  @JsonKey(name: "min_star")
  final num? minStar;
  @JsonKey(name: "sort_type")
  final ProductSortType? sortType;

  SearchQueryModel(this.branchId,
      this.minPrice, this.maxPrice, this.minStar, this.sortType);

  factory SearchQueryModel.fromJson(Map<String, dynamic> json) {
    return _$SearchQueryModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchQueryModelToJson(this);
  }

  factory SearchQueryModel.fromEntity(SearchQueryEntity entity) {
    return SearchQueryModel(
      entity.branchId,
      entity.minPrice,
      entity.maxPrice,
      entity.minStar,
      entity.sortType,
    );
  }
}
