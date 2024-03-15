part of receipt;

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  Future<void> buildShowReasonCancelSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ReceiptBloc>(),
          child: const ReasonCancelSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(builder: (context, state) {
      if (state is ReceiptLoadSuccess) {
        if (state.cancelType != null) {
          return Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      buildShowReasonCancelSheet(context);
                    },
                    child: Text(state.cancelType == OrderStatus.CANCELED
                        ? "Cancel Order"
                        : "Request Cancel Order"),
                  )),
              const Divider(
                height: 20,
              ),
            ],
          );
        } else if (isCancelRequest(state.lastEventLog.orderStatus!)) {
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                    onPressed: null,
                    style: OutlinedButton.styleFrom(
                        disabledForegroundColor: getCancelButtonColor(
                            state.lastEventLog.orderStatus!),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimen.smallRadius),
                        ),
                        side: BorderSide(
                            color: getCancelButtonColor(
                                state.lastEventLog.orderStatus!),
                            width: 1.5,
                            style: BorderStyle.solid)),
                    child: Text(
                        getCancelButtonText(state.lastEventLog.orderStatus!))),
              ),
              const Divider(
                height: 20,
              ),
            ],
          );
        }
      }
      return const SizedBox();
    });
  }

  bool isCancelRequest(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.CANCELLATION_REQUEST ||
        orderStatus == OrderStatus.CANCELLATION_REQUEST_ACCEPTED ||
        orderStatus == OrderStatus.CANCELLATION_REQUEST_REFUSED) {
      return true;
    }
    return false;
  }

  Color getCancelButtonColor(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.CANCELLATION_REQUEST) {
      return AppColor.warning;
    } else if (orderStatus == OrderStatus.CANCELLATION_REQUEST_ACCEPTED) {
      return AppColor.success;
    } else if (orderStatus == OrderStatus.CANCELLATION_REQUEST_REFUSED) {
      return AppColor.info;
    }
    return AppColor.primaryColor;
  }

  String getCancelButtonText(OrderStatus orderStatus) {
    if (orderStatus == OrderStatus.CANCELLATION_REQUEST) {
      return "Request Cancel Send";
    } else if (orderStatus == OrderStatus.CANCELLATION_REQUEST_ACCEPTED) {
      return "Request Cancel Accepted";
    } else if (orderStatus == OrderStatus.CANCELLATION_REQUEST_REFUSED) {
      return "Request Cancel Refused";
    }
    return "";
  }
}
