part of history;

class HistoryList extends StatefulWidget {
  final HistoryStatus historyStatus;
  const HistoryList({Key? key, required this.historyStatus}) : super(key: key);

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late final HistoryBloc _bloc;
  final scrollController = ScrollController();
  late RefreshController _refreshController;
  int initPage = 1;
  int initSize = 8;

  List<OrderHistoryEntity> orderHistoryList = [];
  bool isLoadMore = false;
  bool cannotLoadMore = false;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<HistoryBloc>();
    _bloc.add(HistoryLoadInformation(
        historyStatus: widget.historyStatus, initPage: initPage, initSize: initSize));
    _refreshController = RefreshController(initialRefresh: false);
    scrollController.addListener(_scrollListener);
  }

  @override
  void didUpdateWidget(HistoryList oldWidget) {
    if (oldWidget.historyStatus != widget.historyStatus) {
      // History status has changed, trigger necessary actions here
      _bloc.add(HistoryLoadInformation(
          historyStatus: widget.historyStatus, initPage: initPage, initSize: initSize));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadMore || cannotLoadMore) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(const HistoryLoadMoreInformation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryLoadSuccess) {
            orderHistoryList = state.orderHistoryList;
            isLoadMore = state.isLoadMore;
            cannotLoadMore = state.cannotLoadMore;
          }
        },
        builder: (context, state) {
          switch (state) {
            case HistoryNotAuth():
              return HistoryNotAuthWidget();
            case HistoryLoadInProcess():
              return HistorySkeleton();
            case HistoryLoadSuccess():
              if (orderHistoryList.isNotEmpty) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: false,
                  physics: BouncingScrollPhysics(),
                  onRefresh: () async {
                    _bloc.add(HistoryRefreshInformation(
                        initPage: initPage, initSize: initSize));
                    _refreshController.refreshCompleted();
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: AppDimen.spacing),
                    controller: scrollController,
                    itemCount: isLoadMore
                        ? orderHistoryList.length + 1
                        : orderHistoryList.length,
                    itemBuilder: (context, index) => index <
                            orderHistoryList.length
                        ? InkWell(
                            onTap: () {
                              NavigationUtil.pushNamed(ReceiptPage.route,
                                      arguments: orderHistoryList[index].id)
                                  .then((refresh) {
                                if (refresh != null &&
                                    refresh as bool == true) {
                                  _bloc.add(HistoryLoadInformation(
                                      historyStatus: widget.historyStatus,
                                      initPage: initPage,
                                      initSize: initSize));
                                }
                              });
                            },
                            child: HistoryItem(
                              orderHistory: orderHistoryList[index],
                              isLastItem: index == orderHistoryList.length - 1,
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.all(AppDimen.spacing),
                            child: CupertinoActivityIndicator(),
                          ),
                    separatorBuilder: (context, index) => const Divider(
                      height: 10,
                      thickness: 1,
                    ),
                  ),
                );
              } else {
                return SizedBox(
                    width: double.infinity,
                    child: MyEmptyList(
                      imgPath: AppPath.icNoHistory,
                      text: widget.historyStatus.getEmptyListString(),
                    ));
              }
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
