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
  final String productId;

  ReviewDetailLoadMoreInformation({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
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

