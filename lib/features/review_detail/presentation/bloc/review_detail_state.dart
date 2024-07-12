part of review_detail;

abstract class ReviewDetailState extends Equatable {}

class ReviewDetailInitial extends ReviewDetailState {
  @override
  List<Object> get props => [];
}

class ReviewDetailLoadInProcess extends ReviewDetailState {
  @override
  List<Object> get props => [];
}

class ReviewDetailLoadSuccess extends ReviewDetailState {
  final String productId;
  final List<ChartStackedBarData> reviewStatistic;
  final List<ReviewDetailEntity> reviewDetailList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;
  final ReviewSortType sortType;

  get sortNumber{
    int num = 0;
    if (sortType != null) {
      num++;
    }
    return num;
  }

  ReviewDetailLoadSuccess(
      {required this.productId,
      required this.reviewStatistic,
      required this.reviewDetailList,
      required this.page,
      required this.size,
      this.isLoadMore = false,
      this.cannotLoadMore = false,
      this.sortType = ReviewSortType.CREATED_AT_DESC});

  @override
  List<Object> get props => [
        productId,
        reviewStatistic,
        reviewDetailList,
        page,
        size,
        isLoadMore,
        cannotLoadMore,
        sortType
      ];

  ReviewDetailLoadSuccess copyWith({
    String? productId,
    List<ChartStackedBarData>? reviewStatistic,
    List<ReviewDetailEntity>? reviewDetailList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
    ReviewSortType? sortType,
  }) {
    return ReviewDetailLoadSuccess(
      productId: productId ?? this.productId,
      reviewStatistic: reviewStatistic ?? this.reviewStatistic,
      reviewDetailList: reviewDetailList ?? this.reviewDetailList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
      sortType: sortType ?? this.sortType,
    );
  }
}

class ReviewDetailLoadFailure extends ReviewDetailState {
  @override
  List<Object> get props => [];
}
