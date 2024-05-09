part of review_detail;

abstract class ReviewDetailEvent extends Equatable {}

class ReviewDetailLoadInformation extends ReviewDetailEvent {
  final String productId;
  final int initPage;
  final int initSize;

  ReviewDetailLoadInformation({
    required this.productId,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [productId, initPage, initSize];
}

class ReviewDetailRefreshInformation extends ReviewDetailEvent {
  final String productId;
  final int initPage;
  final int initSize;

  ReviewDetailRefreshInformation({
    required this.productId,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object> get props => [productId, initPage, initSize];
}

class ReviewDetailLoadMoreInformation extends ReviewDetailEvent {

  @override
  List<Object> get props => [];
}

class ReviewDetailLikeBtnPressed extends ReviewDetailEvent {
  final String productReviewId;

  ReviewDetailLikeBtnPressed({
    required this.productReviewId,
  });

  @override
  List<Object> get props => [productReviewId];
}

class ReviewDetailDislikeBtnPressed extends ReviewDetailEvent {
  final String productReviewId;

  ReviewDetailDislikeBtnPressed({
    required this.productReviewId,
  });

  @override
  List<Object> get props => [productReviewId];
}

class ReviewDetailApplySort extends ReviewDetailEvent {
  final ReviewSortType? sortType;
  final int initPage;
  final int initSize;

  ReviewDetailApplySort({
    this.sortType,
    required this.initPage,
    required this.initSize,
  });

  @override
  List<Object?> get props => [sortType, initPage, initSize];
}
