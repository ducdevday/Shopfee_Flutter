part of review;

class ReviewInformationList extends StatefulWidget {
  const ReviewInformationList({
    super.key,
  });

  @override
  State<ReviewInformationList> createState() => _ReviewInformationListState();
}

class _ReviewInformationListState extends State<ReviewInformationList> {
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController = RefreshController(initialRefresh: false);
    super.dispose();
  }

  void handleCreateReview(String id) {
    showDialog(
        context: context,
        builder: (_) => BlocProvider<ReviewBloc>.value(
              value: context.read<ReviewBloc>(),
              child: ReviewDialog(
                orderItemId: id,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoadSuccess) {
          return SmartRefresher(
            controller: _refreshController,
            enablePullUp: false,
            physics: BouncingScrollPhysics(),
            onRefresh: () async {
              context.read<ReviewBloc>().add(ReviewRefreshInformation());
              _refreshController.refreshCompleted();
            },
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.reviewInformationList.length,
              itemBuilder: (context, index) {
                return buildReviewItem(state.reviewInformationList[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: AppDimen.spacing,
                );
              },
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget buildReviewItem(ReviewInformationEntity reviewInformation) {
    return MyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffF0F0F0),
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: reviewInformation.thumbnailUrl ?? "",
                  width: AppDimen.smallImageSize,
                  height: AppDimen.smallImageSize,
                  placeholder: (context, url) => MyPlaceHolderRectangle(
                    width: AppDimen.smallImageSize,
                    height: AppDimen.smallImageSize,
                  ),
                  errorWidget: (_, __, ___) => Image.asset(
                    AppPath.imgImageError,
                    width: AppDimen.smallImageSize,
                    height: AppDimen.smallImageSize,
                  ),
                ),
                SizedBox(
                  width: AppDimen.smallSpacing,
                ),
                Text("${reviewInformation.name}",
                    style: AppStyle.mediumTextStyleDark
                        .copyWith(color: AppColor.headingColor)
                        .copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          if (reviewInformation.review != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${FormatUtil.formatTime(reviewInformation.review!.createdAt)} - ${FormatUtil.formatDate(reviewInformation.review!.createdAt)}",
                  style: AppStyle.normalTextStyleDark,
                ),
                MyStartList(star: reviewInformation.review!.star),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      color: AppColor.dividerColor,
                      size: 20,
                    ),
                    SizedBox(
                      width: AppDimen.spacing,
                    ),
                    Expanded(
                      child: Text(
                        "${reviewInformation.review!.content}",
                        style: AppStyle.normalTextStyleDark,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          if (reviewInformation.review == null)
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                  onPressed: () {
                    handleCreateReview(reviewInformation.id!);
                  },
                  icon: Icon(Icons.keyboard_arrow_right_rounded),
                  label: Text(
                    "Leave a review",
                    style: AppStyle.normalTextStylePrimary
                        .copyWith(fontWeight: FontWeight.w500),
                  )),
            )
        ],
      ),
    );
  }
}
