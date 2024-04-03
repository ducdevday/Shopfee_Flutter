part of review;

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoadInProcess extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoadSuccess extends ReviewState {
  final String orderId;
  final List<ReviewInformationEntity> reviewInformationList;
  final bool haveChanged;

  const ReviewLoadSuccess(
      {required this.orderId,
      required this.reviewInformationList,
      required this.haveChanged});

  @override
  List<Object> get props => [orderId, reviewInformationList, haveChanged];
}

class ReviewLoadFailure extends ReviewState {
  @override
  List<Object> get props => [];
}
