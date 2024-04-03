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
  final List<ReviewDetailEntity> reviewDetailList;
  final int page;
  final int size;
  final bool isLoadMore;
  final bool cannotLoadMore;

  ReviewDetailLoadSuccess({
    required this.reviewDetailList,
    required this.page,
    required this.size,
    this.isLoadMore = false,
    this.cannotLoadMore = false,
  });



  @override
  List<Object> get props =>
      [reviewDetailList, page, size, isLoadMore, cannotLoadMore];

  ReviewDetailLoadSuccess copyWith({
    List<ReviewDetailEntity>? reviewDetailList,
    int? page,
    int? size,
    bool? isLoadMore,
    bool? cannotLoadMore,
  }) {
    return ReviewDetailLoadSuccess(
      reviewDetailList: reviewDetailList ?? this.reviewDetailList,
      page: page ?? this.page,
      size: size ?? this.size,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      cannotLoadMore: cannotLoadMore ?? this.cannotLoadMore,
    );
  }
}

class ReviewDetailLoadFailure extends ReviewDetailState {
  @override
  List<Object> get props => [];
}
