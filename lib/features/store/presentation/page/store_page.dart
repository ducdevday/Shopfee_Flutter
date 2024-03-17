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

  int page = 1;
  int size = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late bool getAll;
  late List<StoreInformationEntity> storeList;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<StoreBloc>();
    getAll = widget.fromRoute == DefaultPage.route;
    _bloc.add(StoreLoadInformation(getAll: getAll, page: page, size: size));
    scrollController = ScrollController();
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
      page = page + 1;
      _bloc.add(StoreLoadMoreInformation(page: page, size: size));
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
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(widget.fromRoute == DefaultPage.route
                ? "All Store"
                : "Choose Store"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
            automaticallyImplyLeading: widget.fromRoute != DefaultPage.route,
          ),
          backgroundColor: const Color(0xffEFEBE9),
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimen.spacing),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          NavigationUtil.pushNamed(StoreSearchPage.route, arguments: getAll);
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
                                borderSide:
                                    const BorderSide(color: Color(0xffCCCCCC)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xffCCCCCC)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    BorderSide(color: AppColor.primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Color(0xffCCCCCC)),
                              ),
                              hintText: "Find Any Store",
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
                          separatorBuilder: (context, index) => const SizedBox(
                            height: AppDimen.spacing,
                          ),
                          itemCount: 10,
                        );
                      case StoreNoLocationPermission():
                        return Center(
                          child: Column(
                            children: [
                              Image.asset(
                                AppPath.icNoLocation,
                                width: 60,
                                height: 60,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Please enable location to see all Stores",
                                style: AppStyle.normalTextStyleDark,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _bloc.add(StoreLoadInformation(
                                        page: page, size: size));
                                  },
                                  style: AppStyle.elevatedButtonStylePrimary,
                                  child: const Text("Enable"))
                            ],
                          ),
                        );
                      case StoreLoadSuccess():
                        if (state.stores.isNotEmpty) {
                          return Stack(
                            children: [
                              StoreListView(
                                  storeList: storeList,
                                  isLoadingMore: isLoadingMore,
                                  currentViewType: state.viewType,
                                  fromRoute: widget.fromRoute),
                              StoreMapView(
                                  storeList: storeList,
                                  currentPosition: state.currentPosition!,
                                  currentViewType: state.viewType,
                                  fromRoute: widget.fromRoute)
                            ],
                          );
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppPath.icNoStore,
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "No Result Found",
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.nonactiveColor),
                                )
                              ],
                            ),
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
    );
  }
}
