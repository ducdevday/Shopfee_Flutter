part of receipt;

class ReceiptBottomAction extends StatelessWidget {
  final String orderId;

  const ReceiptBottomAction({Key? key, required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess && state.showBottomAction()) {
          return BottomAppBar(
            child: Row(
              children: [
                if (state.showRequestRefund())
                  Expanded(
                      child: buildRefundRequestButton(
                          context, orderId, state.receipt.refundRequestStatus)),
                if (state.showRequestRefund())
                  SizedBox(
                    width: AppDimen.spacing,
                  ),
                if (state.showPayNowButton())
                  Expanded(
                      child: SizedBox(
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final orderResult = OrderResult(
                            transactionId: state.receipt.transaction?.id,
                            paymentUrl: state.receipt.transaction?.paymentUrl,
                            orderId: orderId);
                        NavigationUtil.pushNamed(VnPayPage.route,
                            arguments: orderResult);
                      },
                      style: AppStyle.elevatedButtonStylePrimary,
                      child: Text("Pay now"),
                    ),
                  ))
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  OutlinedButton buildRefundRequestButton(BuildContext context, String orderId,
      RefundRequestStatus? refundRequestStatus) {
    if (refundRequestStatus == RefundRequestStatus.CAN_REFUND) {
      return OutlinedButton(
        onPressed: () {
          NavigationUtil.pushNamed(RefundPage.route, arguments: {
            "orderId": orderId,
            "refundRequestStatus": refundRequestStatus
          }).then((haveChanged) {
            if (haveChanged != null && haveChanged as bool == true) {
              context
                  .read<ReceiptBloc>()
                  .add(ReceiptLoadInformation(orderId: orderId, haveChanged: true));
            }
          });
        },
        style: AppStyle.outlineButtonStylePrimary,
        child: Text(
          "Create Request Refund",
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return OutlinedButton(
        onPressed: () {
          NavigationUtil.pushNamed(RefundPage.route, arguments: {
            "orderId": orderId,
            "refundRequestStatus": refundRequestStatus
          });
        },
        style: AppStyle.outlineButtonStylePrimary,
        child: Text(
          "Show Request Refund",
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}
