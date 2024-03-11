part of store;

class StorePage extends StatefulWidget {
  static const int indexPage = 2;

  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final StoreBloc _bloc;

  double? lat;
  double? lng;
  int page = 1;
  int size = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<StoreInformationEntity> storeList;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<StoreBloc>();
    _bloc.add(StoreLoadInformation(page: page, size: size));
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
      _bloc.add(
          StoreLoadMoreInformation(lat: lat, lng: lng, page: page, size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocListener<StoreBloc, StoreState>(
        listener: (context, state) {
          switch (state) {
            case StoreEnableLocationPermission():
              lat = state.lat;
              lng = state.lng;
              break;
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
            title: const Text("All Store"),
            actions: [const Icon(Icons.notifications_none_outlined)],
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          backgroundColor: const Color(0xffEFEBE9),
          body: Padding(
            padding: const EdgeInsets.all(AppDimen.spacing),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: AppStyle.smallTextStyleDark,
                        onChanged: (value) => {},
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          suffixIcon: const Icon(Icons.search),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:
                                BorderSide(color: AppColor.primaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                          ),
                          hintText: "Find Any Store",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.map,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: BlocBuilder<StoreBloc, StoreState>(
                    builder: (context, state) {
                      switch (state) {
                        case StoreLoadInProcess():
                          return ListView.separated(
                            padding: const EdgeInsets.only(top: AppDimen.spacing),
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
                                      _bloc.add(StoreLoadInformation(page: page, size: size));
                                    },
                                    child: const Text("Enable"),
                                    style: AppStyle.elevatedButtonStylePrimary)
                              ],
                            ),
                          );
                        case StoreLoadSuccess():
                          if (state.stores.isNotEmpty) {
                            return ListView.separated(
                              padding: const EdgeInsets.only(top: AppDimen.spacing),
                              itemBuilder: (context, index) => index <
                                      storeList.length
                                  ? StoreItem(store: storeList[index])
                                  : const Padding(
                                      padding: EdgeInsets.all(AppDimen.spacing),
                                      child: CupertinoActivityIndicator(),
                                    ),
                              separatorBuilder: (context, index) => const SizedBox(
                                height: AppDimen.spacing,
                              ),
                              itemCount: isLoadingMore
                                  ? storeList.length + 1
                                  : storeList.length,
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
                                        .copyWith(
                                            color: AppColor.nonactiveColor),
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
      ),
    );
  }
}


