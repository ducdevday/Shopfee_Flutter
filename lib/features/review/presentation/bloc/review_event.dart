part of review;

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class ReviewLoadInformation extends ReviewEvent {
  final String orderId;
  final bool haveChanged;

  const ReviewLoadInformation({
    required this.orderId,
    this.haveChanged = false,
  });

  @override
  List<Object> get props => [orderId, haveChanged];
}

class ReviewCreateNew extends ReviewEvent {
  final String orderItemId;
  final int star;
  final String content;

  const ReviewCreateNew({
    required this.orderItemId,
    required this.star,
    required this.content,
  });

  @override
  List<Object> get props => [orderItemId, star, content];
}