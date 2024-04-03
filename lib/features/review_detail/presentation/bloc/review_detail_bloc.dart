part of review_detail;

class ReviewDetailBloc extends Bloc<ReviewDetailEvent, ReviewDetailState> {
  final ReviewDetailUseCase _reviewDetailUseCase;

  ReviewDetailBloc(this._reviewDetailUseCase) : super(ReviewDetailInitial()) {
    on<ReviewDetailLoadInformation>(_onReviewDetailLoadInformation);
    on<ReviewDetailLoadMoreInformation>(_onReviewDetailLoadMoreInformation);
    on<ReviewDetailLikeBtnPressed>(_onReviewDetailLikeBtnPressed);
    on<ReviewDetailDislikeBtnPressed>(_onReviewDetailDislikeBtnPressed);
  }

  FutureOr<void> _onReviewDetailLoadInformation(
      ReviewDetailLoadInformation event,
      Emitter<ReviewDetailState> emit) async {
    try {
      emit(ReviewDetailLoadInProcess());
      final params =
          ReviewDetailParams(page: event.initPage, size: event.initSize);
      final reviewDetailList = await _reviewDetailUseCase.getReviewDetailList(
          event.productId, params);
      emit(ReviewDetailLoadSuccess(
          reviewDetailList: reviewDetailList,
          page: event.initPage,
          size: event.initSize));
    } catch (e) {
      emit(ReviewDetailLoadFailure());
    }
  }

  FutureOr<void> _onReviewDetailLoadMoreInformation(
      ReviewDetailLoadMoreInformation event,
      Emitter<ReviewDetailState> emit) async {
    try {
      if (state is ReviewDetailLoadSuccess) {
        final currentState = state as ReviewDetailLoadSuccess;
        emit(currentState.copyWith(isLoadMore: true));
        final params = ReviewDetailParams(
            page: currentState.page + 1, size: currentState.size);
        final reviewDetailList = await _reviewDetailUseCase.getReviewDetailList(
            event.productId, params);
        if (reviewDetailList.isNotEmpty) {
          emit(currentState.copyWith(
              reviewDetailList: List.from(currentState.reviewDetailList)
                ..addAll(reviewDetailList),
              page: currentState.page + 1,
              isLoadMore: false));
        } else {
          emit(currentState.copyWith(cannotLoadMore: true));
        }
      }
    } catch (e) {
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onReviewDetailLikeBtnPressed(ReviewDetailLikeBtnPressed event, Emitter<ReviewDetailState> emit) async{
    try{
      final result = await _reviewDetailUseCase.likeReview(event.productReviewId, SharedService.getUserId()!);
    }
    catch(e){
      ExceptionUtil.handle(e);
    }
  }

  FutureOr<void> _onReviewDetailDislikeBtnPressed(ReviewDetailDislikeBtnPressed event, Emitter<ReviewDetailState> emit) async{
    try{
      final result = await _reviewDetailUseCase.disLikeReview(event.productReviewId, SharedService.getUserId()!);
    }
    catch(e){
      ExceptionUtil.handle(e);
    }
  }
}
