import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/data/models/review.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final OrderRepository orderRepository;

  ReviewCubit({required this.orderRepository}) : super(ReviewInitial());

  void initReview() {
    emit(ReviewLoaded());
  }

  void rateStar(int star) {
    if (state is ReviewLoaded) {
      final currentState = state as ReviewLoaded;
      emit(currentState.copyWith(rating: star));
    }
  }

  void writeContent(String content) {
    if (state is ReviewLoaded) {
      final currentState = state as ReviewLoaded;
      emit(currentState.copyWith(content: content));
    }
  }

  void sendReview(String orderId) async {
    if (state is ReviewLoaded) {
      try {
        final currentState = state as ReviewLoaded;
        EasyLoading.show();
        var response = await orderRepository.createReview(orderId,
            Review(rating: currentState.rating, content: currentState.content));
        EasyLoading.dismiss();
        if (response.success) {
          EasyLoading.showInfo("Thank you, your review has been recorded",
              duration: Duration(milliseconds: 1000));
          Future.delayed(Duration(milliseconds: 1000), () {
            emit(ReviewFinished());
          });
        } else {
          EasyLoading.showError("Something went wrong! Please try later",
              duration: Duration(milliseconds: 1000));
        }
      } catch (e) {
        print(e);
        EasyLoading.showError("Something went wrong! Please try later",
            duration: Duration(milliseconds: 1000));
      }
    }
  }
}
