part of order;

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderLoadInformation extends OrderEvent {
  final int page;
  final int size;

  const OrderLoadInformation({
    required this.page,
    required this.size,
  });

  @override
  List<Object?> get props =>
      [page, size];
}

class OrderLoadMoreInformation extends OrderEvent {
  final int page;
  final int size;

  const OrderLoadMoreInformation({
    required this.page,
    required this.size,
  });

  @override
  List<Object> get props => [page, size];
}

class OrderChooseCategory extends OrderEvent {
  final CategoryEntity category;
  final int page;
  final int size;
  final num? minPrice;
  final num? maxPrice;
  final num? minStar;
  final ProductSortType? sortType;

  const OrderChooseCategory({
    required this.category,
    required this.page,
    required this.size,
    this.minPrice, this.maxPrice, this.minStar, this.sortType,
  });

  @override
  List<Object?> get props =>
      [category, page, size, minPrice, maxPrice, minStar, sortType,];
}

class OrderClearFilter extends OrderEvent {
  final CategoryEntity category;
  final int page;
  final int size;

  const OrderClearFilter({
    required this.category,
    required this.page,
    required this.size,
  });

  @override
  List<Object> get props => [category, page, size];
}

class OrderChangeViewType extends OrderEvent {
  final ProductViewType viewType;

  const OrderChangeViewType({
    required this.viewType,
  });

  @override
  List<Object> get props => [viewType];
}
