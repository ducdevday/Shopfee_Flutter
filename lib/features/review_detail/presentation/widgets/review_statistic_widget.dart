part of review_detail;

class ReviewStatisticWidget extends StatefulWidget {
  const ReviewStatisticWidget({
    super.key,
    required this.ratingSummary,
  });

  final RatingSummaryEntity ratingSummary;

  @override
  State<ReviewStatisticWidget> createState() => _ReviewStatisticWidgetState();
}

class _ReviewStatisticWidgetState extends State<ReviewStatisticWidget> {
  @override
  Widget build(BuildContext context) {
    return MyContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(
              "${widget.ratingSummary.star ?? 0}",
              style: AppStyle.largeRatingStyle,
            ),
            Text(
              "of 5",
              style: AppStyle.mediumTextStyleDark,
            ),
            Text(
              "${widget.ratingSummary.quantity ?? 0} Reviews",
              style: AppStyle.mediumTextStyleDark,
            )
          ],
        ),
        SizedBox(
          width: AppDimen.smallPadding,
        ),
        Expanded(
          child: BlocBuilder<ReviewDetailBloc, ReviewDetailState>(
            builder: (context, state) {
              if (state is ReviewDetailLoadSuccess) {
                return Column(
                  children: [
                    SizedBox(height: AppDimen.spacing,),
                    Column(
                      children: [
                        ...state.reviewStatistic.map((e) => Row(
                              children: [
                                MyStartList(
                                  star: e.star,
                                  showUnActive: false,
                                  size: 12,
                                ),
                                Expanded(
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: e.current/e.total,
                                    barRadius: Radius.circular(7),
                                    backgroundColor: Colors.grey,
                                    progressColor: AppColor.rating,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ],
                );
              }
              return SizedBox();
            },
          ),
        )
      ],
    ));
  }
}