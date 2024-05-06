part of coin;

class CoinPage extends StatefulWidget {
  static const String route = "/coin";
  final String userId;

  const CoinPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  late CoinBloc _bloc;
  int initPage = 1;
  int initSize = 8;
  bool isLoadingMore = false;
  bool cannotLoadMore = false;
  List<CoinHistoryEntity> coinHistoryList = const [];
  late ScrollController _scrollController;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<CoinBloc>()
      ..add(CoinLoadInformation(
          userId: widget.userId, initPage: initPage, initSize: initSize));
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _bloc.close();
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _bloc.add(CoinLoadMoreInformation(userId: widget.userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: RefreshConfiguration.copyAncestor(
        context: context,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Coin History"),
            centerTitle: true,
            backgroundColor: Colors.white,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppDimen.spacing),
            child: BlocBuilder<CoinBloc, CoinState>(
              builder: (context, state) {
                switch (state) {
                  case CoinLoadInProcess():
                    return Center(child: CupertinoActivityIndicator());
                  case CoinLoadSuccess():
                    isLoadingMore = state.isLoadMore;
                    cannotLoadMore = state.cannotLoadMore;
                    coinHistoryList = state.coinHistoryList;
                    return Column(
                      children: [
                        Expanded(
                            child: SmartRefresher(
                                controller: _refreshController,
                                enablePullUp: false,
                                physics: BouncingScrollPhysics(),
                                onRefresh: () async {
                                  _bloc.add(CoinRefreshInformation(
                                      userId: widget.userId,
                                      initPage: initPage,
                                      initSize: initSize));
                                  _refreshController.refreshCompleted();
                                },
                                child: buildCoinHistoryList()))
                      ],
                    );
                  case CoinLoadFailure():
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

  Widget buildCoinHistoryList() {
    if (coinHistoryList.isNotEmpty) {
      return ListView.separated(
          controller: _scrollController,
          itemBuilder: (context, index) => index < coinHistoryList.length
              ? CoinHistoryItem(coinHistory: coinHistoryList[index])
              : const Padding(
                  padding: EdgeInsets.all(AppDimen.spacing),
                  child: CupertinoActivityIndicator(),
                ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: isLoadingMore
              ? coinHistoryList.length + 1
              : coinHistoryList.length);
    } else {
      return MyEmptyList(
          imgPath: AppPath.icNoCoin, text: "No Coins Fluctuations");
    }
  }
}
