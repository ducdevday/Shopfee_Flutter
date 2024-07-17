part of receipt;

class ReviewSummary extends StatelessWidget {
  final String orderId;

  const ReviewSummary({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess &&
            state.lastEventLog.orderStatus == OrderStatus.SUCCEED) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(color: const Color(0xffF0F0F0))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimen.smallSpacing, horizontal: 8),
                        color: const Color(0xffF0F0F0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.receipt.needReview ?? false
                                  ? R.youNotReview.tr()
                                  : R.thankYouForReview.tr(),
                              style: AppStyle.mediumTextStyleDark,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: () {
                                NavigationUtil.pushNamed(ReviewPage.route,
                                        arguments: orderId)
                                    .then((isRefresh) {
                                  // if (isRefresh != null && isRefresh == true) {
                                    context.read<ReceiptBloc>().add(
                                        ReceiptLoadInformation(
                                            orderId: orderId));
                                  // }
                                });
                              },
                              child: Text(
                                state.receipt.needReview ?? false
                                    ? R.reviewNow.tr()
                                    : R.seeReview.tr(),
                                style: AppStyle.normalTextStylePrimary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 20,
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
