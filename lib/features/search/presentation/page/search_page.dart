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
  late TextEditingController textEditingController;
  late DebounceController debounceController;
  String query = "";
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ProductInformationEntity> productList;
  late List<String> autoCompleteList;
  late List<String> highLightList;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<SearchCubit>();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    textEditingController = TextEditingController();
    debounceController = DebounceController();
  }

  @override
  void dispose() {
    _cubit.close();
    scrollController.dispose();
    textEditingController.dispose();
    debounceController.dispose();
    super.dispose();
  }

  void handleSearchProduct(String value) {
    debounceController.run(() => _cubit.getAutoCompleteProductName(value));
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
            if (state is SearchLoadAutoCompleteSuccess) {
              highLightList = state.autocompleteProductEntity.highlightTextList;
              autoCompleteList = state.autocompleteProductEntity.autocompleteTextList;
            } else if (state is SearchLoadProductSuccess) {
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
                          controller: textEditingController,
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
                              borderSide:
                                  BorderSide(color: AppColor.primaryColor),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoadAutoCompleteSuccess)
                      return SizedBox();
                    return Divider(height: 1);
                  },
                ),
              ),
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                switch (state) {
                  case SearchLoadInProcess():
                    return Center(child: CupertinoActivityIndicator());
                  case SearchLoadAutoCompleteSuccess():
                    if (highLightList.isNotEmpty && textEditingController.value.text.isNotEmpty) {
                      return ListView.separated(
                        itemCount: highLightList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: AppDimen.screenPadding),
                          child: GestureDetector(
                            onTap: () {
                              _cubit.chooseAutoCompleteProductName(autoCompleteList[index]);
                              textEditingController.text = autoCompleteList[index];
                            },
                            child: HtmlWidget(
                              '''${highLightList[index]}''',
                              customStylesBuilder: (element) {
                                if (element.localName == "em")
                                  return {
                                    'color': "#5D4037",
                                    'font-style': 'normal',
                                    'font-weight': 'bold'
                                  };
                                return null;
                              },

                              customWidgetBuilder: (element) {
                                return null;
                              },
                              renderMode: RenderMode.column,

                              // set the default styling for text
                              textStyle: AppStyle.normalTextStyleDark,
                            ),
                          ),
                        ),
                        separatorBuilder: (context, int index) => const Divider(
                          height: 8,
                          thickness: 0.75,
                        ),
                      );
                    } else if (textEditingController.value.text.isNotEmpty) {
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
                              "No Product Found",
                              style: AppStyle.mediumTextStyleDark
                                  .copyWith(color: AppColor.nonactiveColor),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  case SearchLoadProductSuccess():
                    if (productList.isNotEmpty && query.isNotEmpty) {
                      return ListView.separated(
                        controller: scrollController,
                        padding: EdgeInsets.only(top: AppDimen.screenPadding),
                        itemCount: isLoadingMore
                            ? productList.length + 1
                            : productList.length,
                        itemBuilder: (context, index) => index <
                                productList.length
                            ? HomeProduct(
                                product: productList[index],
                                viewType: ProductViewType.List_View_Vertical,
                              )
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
                              "No Product Found",
                              style: AppStyle.mediumTextStyleDark
                                  .copyWith(color: AppColor.nonactiveColor),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  case SearchLoadFailure():
                    return MyErrorWidget();
                  default:
                    return SizedBox();
                }
              },
            ),
          ),
        ));
  }
}
