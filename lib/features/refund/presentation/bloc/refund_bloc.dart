part of refund;

class RefundBloc extends Bloc<RefundEvent, RefundState> {
  RefundBloc() : super(RefundInitial()) {
    on<RefundEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
