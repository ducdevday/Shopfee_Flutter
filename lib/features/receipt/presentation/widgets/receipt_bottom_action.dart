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
                if (state.showRequestReturnOrRefund())
                  Expanded(
                      child: OutlinedButton(
                    onPressed: () {
                      NavigationUtil.pushNamed(RefundPage.route,
                          arguments: orderId);
                    },
                    style: AppStyle.outlineButtonStylePrimary,
                    child: Text(
                      "Request Refund",
                      textAlign: TextAlign.center,
                    ),
                  )),
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
}
