part of store;

class StoreSearchPage extends StatefulWidget {
  static const String route = "/store_search";
  final bool getAll;

  const StoreSearchPage({Key? key, required this.getAll}) : super(key: key);

  @override
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  late final StoreBloc _bloc;

  int page = 1;
  int size = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  String query = "";
  late bool getAll;
  late List<StoreInformationEntity> storeList;
  late ScrollController scrollController;
  late DebounceController debounceController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<StoreBloc>();
    getAll = widget.getAll;
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    debounceController = DebounceController();
  }
  @override
  void dispose() {
    _bloc.close();
    scrollController.dispose();
    debounceController.dispose();
    super.dispose();
  }

  void handleSearchProduct(String value) {
    page = 1;
    size = 8;
    debounceController.run(() => _bloc.add(StoreLoadInformation(
        query: value, getAll: getAll, page: page, size: size)));
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
            if (state is StoreLoadSuccess) {
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              storeList = state.stores;
              query = state.query;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: "Store_Search_Bar",
                        child: TextField(
                          autofocus: true,
                          style: AppStyle.smallTextStyleDark,
                          onChanged: (value) => handleSearchProduct(value),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            suffixIcon: Icon(Icons.search),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: AppColor.primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: Color(0xffCCCCCC)),
                            ),
                            hintText: "Find store by name or address",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(
                        "Cancel",
                        style: AppStyle.normalTextStylePrimary,
                      ),
                    )
                  ],
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if(state is StoreLoadInProcess){
                  return Center(child: CupertinoActivityIndicator());
                }
                else if (state is StoreLoadSuccess) {
                  if (storeList.isNotEmpty && query.isNotEmpty) {
                    return ListView.separated(
                      controller: scrollController,
                      padding: EdgeInsets.only(top: AppDimen.screenPadding),
                      itemCount: isLoadingMore
                          ? storeList.length + 1
                          : storeList.length,
                      itemBuilder: (context, index) =>
                      index < storeList.length
                          ? StoreItem(store: storeList[index],fromRoute: StoreSearchPage.route,)
                          : const Padding(
                        padding: EdgeInsets.all(AppDimen.spacing),
                        child: CupertinoActivityIndicator(),
                      ),
                      separatorBuilder: (context, int index) => const Divider(
                        height: 8,
                        thickness: 0.75,
                      ),
                    );
                  } else if (query.isNotEmpty) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppPath.icStore,
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(
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
                  } else {
                    return SizedBox();
                  }
                }
                else if(state is SearchLoadFailure){
                  return MyErrorWidget();
                }
                else {
                  return SizedBox();
                }
              },
            ),
          ),
        ));
  }
}
