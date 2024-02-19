part of history;

class HistoryPage extends StatefulWidget {
  static const String route = "/history";

  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryBloc _bloc;
  final scrollController = ScrollController();
  late bool isLoadingMore;
  late bool cannotLoadMore;
  HistoryStatus historyStatus = HistoryStatus.Processing;
  List<OrderHistoryEntity> orderHistoryList = [];

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<HistoryBloc>()
      ..add(LoadHistory(historyStatus: historyStatus));
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(LoadMoreHistory(historyStatus: historyStatus));
    }
  }

  String? getEmptyListString(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.Processing:
        return "No Order In Processing";
      case HistoryStatus.Done:
        return "No Order Has Done";
      case HistoryStatus.Canceled:
        return "No Order Has Canceled";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state is HistoryLoaded) {
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              historyStatus = state.historyStatus;
              orderHistoryList = state.orderHistoryList;
            }
          },
          child: RefreshIndicator(
            onRefresh: () async {
              _bloc.add(LoadHistory(historyStatus: historyStatus));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  const HistoryFilter(),
                  Expanded(
                    child: BlocBuilder<HistoryBloc, HistoryState>(
                      builder: (context, state) {
                        switch (state) {
                          case HistoryNotAuth():
                            return HistoryNotAuthWidget();
                          case HistoryLoading():
                            return HistorySkeleton();
                          case HistoryLoaded():
                            if (orderHistoryList.isNotEmpty) {
                              return ListView.separated(
                                padding: EdgeInsets.only(top: AppDimen.spacing),
                                controller: scrollController,
                                itemCount: isLoadingMore
                                    ? orderHistoryList.length + 1
                                    : orderHistoryList.length,
                                itemBuilder: (context, index) => index <
                                        orderHistoryList.length
                                    ? InkWell(
                                        onTap: () {
                                          NavigationUtil.pushNamed(
                                                  ReceiptPage.route,
                                                  arguments:
                                                      orderHistoryList[index]
                                                          .id)
                                              .then((value) {
                                            if (value != null &&
                                                value as bool == true) {
                                              _bloc.add(LoadHistory(
                                                  historyStatus:
                                                      historyStatus));
                                            }
                                          });
                                        },
                                        child: HistoryItem(
                                          index: index,
                                        ),
                                      )
                                    : const Padding(
                                        padding:
                                            EdgeInsets.all(AppDimen.spacing),
                                        child: CupertinoActivityIndicator(),
                                      ),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  height: 10,
                                  thickness: 1,
                                ),
                              );
                            } else {
                              return Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      AppPath.icCoffee,
                                      width: 60,
                                      height: 60,
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      getEmptyListString(state.historyStatus) ??
                                          "",
                                      style: AppStyle.mediumTextStyleDark
                                          .copyWith(
                                              color: AppColor.nonactiveColor),
                                    )
                                  ],
                                ),
                              );
                            }
                          default:
                            return SizedBox();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
