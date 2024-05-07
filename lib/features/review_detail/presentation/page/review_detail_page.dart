part of review_detail;

class ReviewDetailPage extends StatefulWidget {
  static const String route = "/review_detail";
  final ReviewDetailArguments arguments;

  const ReviewDetailPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  late ReviewDetailBloc _bloc;
  late String productId;
  late RatingSummaryEntity ratingSummary;
  late RefreshController _refreshController;

  int initPage = 1;
  int initSize = 8;

  @override
  void initState() {
    super.initState();
    productId = widget.arguments.productId;
    ratingSummary = widget.arguments.ratingSummary;
    _bloc = ServiceLocator.sl<ReviewDetailBloc>()
      ..add(ReviewDetailLoadInformation(
          productId: productId, initPage: initPage, initSize: initSize));
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _bloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: RefreshConfiguration.copyAncestor(
        context: context,
        child: Scaffold(
          backgroundColor: AppColor.scaffoldColorBackground,
          appBar: AppBar(
            title: Text("All Review"),
            backgroundColor: Colors.white,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppDimen.spacing),
            child: BlocBuilder<ReviewDetailBloc, ReviewDetailState>(
              builder: (context, state) {
                switch (state) {
                  case ReviewDetailLoadInProcess():
                    return Center(child: CupertinoActivityIndicator());
                  case ReviewDetailLoadSuccess():
                    return Column(
                      children: [
                        ReviewStatisticWidget(ratingSummary: ratingSummary),
                        SizedBox(
                          height: AppDimen.spacing,
                        ),
                        Expanded(
                            child: SmartRefresher(
                                controller: _refreshController,
                                enablePullUp: false,
                                physics: BouncingScrollPhysics(),
                                onRefresh: () async {
                                  context.read<ReviewDetailBloc>().add(
                                      ReviewDetailRefreshInformation(
                                          productId: productId,
                                          initPage: initPage,
                                          initSize: initSize));
                                  _refreshController.refreshCompleted();
                                },
                                child: ReviewDetailList(productId: productId)))
                      ],
                    );
                  case ReviewDetailLoadFailure():
                    return MyErrorWidget();
                  default:
                    return SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

