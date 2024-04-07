part of review;

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final ReviewUseCase _reviewUseCase;

  ReviewBloc(this._reviewUseCase) : super(ReviewInitial()) {
    on<ReviewLoadInformation>(_onReviewLoadInformation);
    on<ReviewRefreshInformation>(_onReviewRefreshInformation);
    on<ReviewCreateNew>(_onReviewCreateNew);
  }

  FutureOr<void> _onReviewLoadInformation(
      ReviewLoadInformation event, Emitter<ReviewState> emit) async {
    try {
      emit(ReviewLoadInProcess());
      final reviews = await _reviewUseCase.getOrderReviewItem(event.orderId);
      emit(ReviewLoadSuccess(
          orderId: event.orderId,
          reviewInformationList: reviews,
          haveChanged: event.haveChanged));
    } catch (e) {
      emit(ReviewLoadFailure());
    }
  }

  FutureOr<void> _onReviewRefreshInformation(
      ReviewRefreshInformation event, Emitter<ReviewState> emit) async {
    try {
      if (state is ReviewLoadSuccess) {
        final currentState = state as ReviewLoadSuccess;
        final reviews =
            await _reviewUseCase.getOrderReviewItem(currentState.orderId);
        emit(ReviewLoadSuccess(
            orderId: currentState.orderId,
            reviewInformationList: reviews,
            haveChanged: currentState.haveChanged));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onReviewCreateNew(
      ReviewCreateNew event, Emitter<ReviewState> emit) async {
    try {
      if (state is ReviewLoadSuccess) {
        final currentState = state as ReviewLoadSuccess;
        EasyLoading.show();
        final reviewParams = ReviewParams(
            orderItemId: event.orderItemId,
            star: event.star,
            content: event.content);
        final result = await _reviewUseCase.createNewReview(reviewParams);
        EasyLoading.dismiss();
        add(ReviewLoadInformation(orderId: currentState.orderId));
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }
}
