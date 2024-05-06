part of order;

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

class OrderLoadInformation extends OrderEvent {
  final int initPage;
  final int initSize;

  const OrderLoadInformation({
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object?> get props => [initPage, initSize];
}

class OrderRefreshInformation extends OrderEvent {
  final int initPage;
  final int initSize;

  const OrderRefreshInformation({
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object?> get props => [initPage, initSize];
}

class OrderLoadMoreInformation extends OrderEvent {
  @override
  List<Object> get props => [];
}

// class OrderChooseCategory extends OrderEvent {
//   final CategoryEntity category;
//   final int page;
//   final int size;
//   final num? minPrice;
//   final num? maxPrice;
//   final num? minStar;
//   final ProductSortType? sortType;
//
//   const OrderChooseCategory({
//     required this.category,
//     required this.page,
//     required this.size,
//     this.minPrice,
//     this.maxPrice,
//     this.minStar,
//     this.sortType,
//   });
//
//   @override
//   List<Object?> get props => [
//         category,
//         page,
//         size,
//         minPrice,
//         maxPrice,
//         minStar,
//         sortType,
//       ];
// }

class OrderSelectCategory extends OrderEvent {
  final CategoryEntity category;
  final int initPage;
  final int initSize;

  const OrderSelectCategory(
      {required this.category, required this.initPage, required this.initSize});

  @override
  List<Object> get props => [category, initPage, initSize];
}

class OrderApplyFilter extends OrderEvent {
  final num? minPrice;
  final num? maxPrice;
  final num? minStar;
  final int initPage;
  final int initSize;

  const OrderApplyFilter({
    this.minPrice,
    this.maxPrice,
    this.minStar,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object?> get props => [
        minPrice,
        maxPrice,
        minStar,
        initPage,
        initSize,
      ];
}

class OrderApplySort extends OrderEvent {
  final ProductSortType? sortType;
  final int initPage;
  final int initSize;

  const OrderApplySort({
    this.sortType,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object?> get props => [sortType, initPage, initSize];
}

class OrderChangeViewType extends OrderEvent {
  final ProductViewType viewType;

  const OrderChangeViewType({
    required this.viewType,
  });

  @override
  List<Object> get props => [viewType];
}
