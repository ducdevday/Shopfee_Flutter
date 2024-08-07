part of store;

class StorePage extends StatefulWidget {
  static const String route = "/store";
  static const int indexPage = 2;
  final String fromRoute;

  const StorePage({Key? key, this.fromRoute = DefaultPage.route})
      : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final StoreBloc _bloc;

  int initPage = 1;
  int initSize = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late bool getAll;
  late List<StoreInformationEntity> storeList;
  late ScrollController scrollController;
  late final RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<StoreBloc>();
    getAll = widget.fromRoute == DefaultPage.route;
    _bloc.add(StoreLoadInformation(getAll: getAll, initPage: initPage, initSize: initSize));
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(StoreLoadMoreInformation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<StoreBloc, StoreState>(
        listener: (context, state) {
          switch (state) {
            case StoreLoadSuccess():
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              storeList = state.stores;
              break;
          }
        },
        child: RefreshConfiguration.copyAncestor(
          context: context,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(widget.fromRoute == DefaultPage.route
                  ? R.allStore.tr()
                  : R.chooseStore.tr()),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
              automaticallyImplyLeading: widget.fromRoute != DefaultPage.route,
            ),
            backgroundColor: AppColor.scaffoldColorBackground,
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(AppDimen.spacing),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigationUtil.pushNamed(StoreSearchPage.route,
                                arguments: getAll);
                          },
                          child: Hero(
                            tag: "Store_Search_Bar",
                            child: TextField(
                              enabled: false,
                              style: AppStyle.smallTextStyleDark,
                              onChanged: null,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                suffixIcon: const Icon(Icons.search),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xffCCCCCC)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xffCCCCCC)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide:
                                      BorderSide(color: AppColor.primaryColor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xffCCCCCC)),
                                ),
                                hintText: R.findStore.tr(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      BlocBuilder<StoreBloc, StoreState>(
                        builder: (context, state) {
                          if (state is StoreLoadSuccess) {
                            if (state.viewType == StoreViewType.List_View) {
                              return InkWell(
                                onTap: () {
                                  _bloc.add(const StoreChangeViewType(
                                      viewType: StoreViewType.Map_View));
                                },
                                child: Icon(
                                  Icons.map,
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  _bloc.add(const StoreChangeViewType(
                                      viewType: StoreViewType.List_View));
                                },
                                child: Icon(
                                  Icons.list,
                                ),
                              );
                            }
                          }
                          return Icon(
                            Icons.map,
                          );
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<StoreBloc, StoreState>(
                    builder: (context, state) {
                      switch (state) {
                        case StoreLoadInProcess():
                          return ListView.separated(
                            padding: const EdgeInsets.only(
                                top: AppDimen.spacing,
                                left: AppDimen.spacing,
                                right: AppDimen.spacing),
                            itemBuilder: (context, index) => StoreSkeleton(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: AppDimen.spacing,
                            ),
                            itemCount: 10,
                          );
                        case StoreNoLocationPermission():
                          return StoreNoPermission(initPage: initPage, initSize: initSize);
                        case StoreLoadSuccess():
                          if (state.stores.isNotEmpty) {
                            return Stack(
                              children: [
                                StoreListView(
                                  storeList: storeList,
                                  isLoadingMore: isLoadingMore,
                                  currentViewType: state.viewType,
                                  fromRoute: widget.fromRoute,
                                  refreshController: _refreshController,
                                ),
                                StoreMapView(
                                    storeList: storeList,
                                    currentPosition: state.currentPosition!,
                                    currentViewType: state.viewType,
                                    fromRoute: widget.fromRoute)
                              ],
                            );
                          } else {
                            return Expanded(
                              child: MyEmptyList(
                                  imgPath: AppPath.icNoStore,
                                  text: R.noStoreFound.tr()),
                            );
                          }
                        case StoreLoadFailure():
                          return const MyErrorWidget();
                        default:
                          return const SizedBox();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}