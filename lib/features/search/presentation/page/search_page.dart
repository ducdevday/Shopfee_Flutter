part of search;

class SearchPage extends StatefulWidget {
  static const route = "/search";
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit _cubit;
  late ScrollController scrollController;
  late DebounceController debounceController;
  String query = "";
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ProductInformationEntity> productList;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<SearchCubit>();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    debounceController = DebounceController();
  }

  @override
  void dispose() {
    _cubit.close();
    scrollController.dispose();
    debounceController.dispose();
    super.dispose();
  }

  void handleSearchProduct(String value){
    debounceController.run(() => _cubit.searchProduct(value));
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _cubit.loadMoreProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _cubit,
        child: BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchLoadSuccess) {
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              productList = state.products;
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
                        tag: "Home_Search_Bar",
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
                            hintText: "What would you like to drink today?",
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
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if(state is SearchLoadInProcess){
                  return Center(child: CupertinoActivityIndicator());
                }
                else if (state is SearchLoadSuccess) {
                  if (productList.isNotEmpty && query.isNotEmpty) {
                    return ListView.separated(
                      controller: scrollController,
                      padding: EdgeInsets.only(top: AppDimen.screenPadding),
                      itemCount: isLoadingMore
                          ? productList.length + 1
                          : productList.length,
                      itemBuilder: (context, index) =>
                          index < productList.length
                              ? HomeProduct(product: productList[index], viewType: ProductViewType.List_View_Vertical,)
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
                            AppPath.icNoProduct,
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
