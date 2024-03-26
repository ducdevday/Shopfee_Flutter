part of receipt;
class ReviewSummary extends StatelessWidget {
  const ReviewSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess ) {
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
                                  ? "You haven't leave a review yet"
                                  : "Thank you for your review",
                              style: AppStyle.mediumTextStyleDark,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: () {
                                NavigationUtil.pushNamed(ReviewPage.route,
                                    arguments: state.receipt.itemList);
                              },
                              child: Text(
                                state.receipt.needReview ?? false
                                    ? "Review now"
                                    : "See history review",
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
