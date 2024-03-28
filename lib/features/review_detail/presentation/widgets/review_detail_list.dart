part of review_detail;

class ReviewDetailList extends StatefulWidget {
  final String productId;

  const ReviewDetailList({Key? key, required this.productId}) : super(key: key);

  @override
  State<ReviewDetailList> createState() => _ReviewDetailListState();
}

class _ReviewDetailListState extends State<ReviewDetailList> {
  late ScrollController scrollController;
  bool isLoadingMore = false;
  bool cannotLoadMore = false;
  List<ReviewDetailEntity> reviewDetailList = const[];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context
          .read<ReviewDetailBloc>()
          .add(ReviewDetailLoadMoreInformation(productId: widget.productId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewDetailBloc, ReviewDetailState>(
      builder: (context, state) {
        if (state is ReviewDetailLoadSuccess) {
          isLoadingMore = state.isLoadMore;
          cannotLoadMore = state.cannotLoadMore;
          reviewDetailList = state.reviewDetailList;
          if(reviewDetailList.isNotEmpty) {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) => index < reviewDetailList.length
                  ? ReviewDetailItem(reviewDetail: reviewDetailList[index])
                  : const Padding(
                      padding: EdgeInsets.all(AppDimen.spacing),
                      child: CupertinoActivityIndicator(),
                    ),
              separatorBuilder: (context, index) => SizedBox(
                    height: AppDimen.spacing,
                  ),
              itemCount: isLoadingMore
                  ? reviewDetailList.length + 1
                  : reviewDetailList.length);
          }
          else{
            return MyEmptyList(imgPath: AppPath.icNoReview, text: "No Reviews Found");
          }
        }
        return SizedBox();
      },
    );
  }
}
