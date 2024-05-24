import 'package:shopfee/core/common/enum/product_sort_type.dart';

class OrderQueryEntity {
  final String? branchId;
  final num? minPrice;
  final num? maxPrice;
  final num? minStar;
  final ProductSortType? sortType;

  const OrderQueryEntity({
    this.branchId,
    this.minPrice,
    this.maxPrice,
    this.minStar,
    this.sortType,
  });
}
