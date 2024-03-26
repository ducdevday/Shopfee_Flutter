part of receipt;

class ReceiptBottomAction extends StatelessWidget {
  const ReceiptBottomAction({Key? key}) : super(key: key);

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
                  onPressed: () {},
                  style: AppStyle.outlineButtonStylePrimary,
                  child: Text(
                    "Request a return or refund",
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
                          paymentUrl: state.receipt.transaction?.paymentUrl);
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
