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
  late RefreshController _refreshController;
  HistoryStatus historyStatus = HistoryStatus.WAITING;
  int initPage = 1;
  int initSize = 8;
  late OrderHistoryGroupEntity orderHistoryGroup;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<HistoryBloc>();
    _bloc.add(HistoryLoadInformationInitialize(
        historyStatus: historyStatus, initPage: initPage, initSize: initSize));
    _refreshController = RefreshController(initialRefresh: false);
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (orderHistoryGroup.isLoadMore || orderHistoryGroup.cannotLoadMore) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(const HistoryLoadMoreInformationByStatus());
    }
  }

  String? getEmptyListString(HistoryStatus status) {
    switch (status) {
      case HistoryStatus.WAITING:
        return "No Order In Waiting";
      case HistoryStatus.IN_PROCESS:
        return "No Order In Processing";
      case HistoryStatus.SUCCEED:
        return "No Order Has Done";
      case HistoryStatus.CANCELED:
        return "No Order Has Canceled";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryLoadSuccess) {
            historyStatus = state.chosenStatus;
            orderHistoryGroup = state.orderHistoryGroup!;
          }
        },
        child: RefreshConfiguration.copyAncestor(
          context: context,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("History"),
              centerTitle: true,
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  HistoryFilter(
                    historyStatus: historyStatus,
                    initPage: initPage,
                    initSize: initSize,
                  ),
                  Expanded(
                    child: BlocBuilder<HistoryBloc, HistoryState>(
                      builder: (context, state) {
                        switch (state) {
                          case HistoryNotAuth():
                            return HistoryNotAuthWidget();
                          case HistoryLoadInProcess():
                            return HistorySkeleton();
                          case HistoryLoadSuccess():
                            final orderHistoryList =
                                orderHistoryGroup.orderHistoryList;
                            if (orderHistoryList.isNotEmpty) {
                              return SmartRefresher(
                                controller: _refreshController,
                                enablePullUp: false,
                                physics: BouncingScrollPhysics(),
                                onRefresh: () async {
                                  context.read<HistoryBloc>().add(
                                      HistoryRefreshInformationByStatus(
                                          initPage: initPage,
                                          initSize: initSize));
                                  _refreshController.refreshCompleted();
                                },
                                child: ListView.separated(
                                  padding:
                                      EdgeInsets.only(top: AppDimen.spacing),
                                  controller: scrollController,
                                  itemCount: orderHistoryGroup.isLoadMore
                                      ? orderHistoryList.length + 1
                                      : orderHistoryList.length,
                                  itemBuilder: (context, index) => index <
                                          orderHistoryGroup
                                              .orderHistoryList.length
                                      ? InkWell(
                                          onTap: () {
                                            NavigationUtil.pushNamed(
                                                    ReceiptPage.route,
                                                    arguments:
                                                        orderHistoryList[index]
                                                            .id)
                                                .then((refresh) {
                                              if (refresh != null &&
                                                  refresh as bool == true) {
                                                _bloc.add(
                                                    HistoryLoadInformationInitialize(
                                                        historyStatus:
                                                            historyStatus,
                                                        initPage: initPage,
                                                        initSize: initSize));
                                              }
                                            });
                                          },
                                          child: HistoryItem(
                                            orderHistory:
                                                orderHistoryList[index],
                                            isLastItem: index ==
                                                orderHistoryList.length - 1,
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
                                ),
                              );
                            } else {
                              return SizedBox(
                                  width: double.infinity,
                                  child: MyEmptyList(
                                    imgPath: AppPath.icNoHistory,
                                    text:
                                        getEmptyListString(historyStatus) ?? "",
                                  ));
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
