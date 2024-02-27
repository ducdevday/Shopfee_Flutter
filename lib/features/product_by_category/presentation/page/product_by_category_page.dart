part of product_by_category;

enum ViewType { List_View, Grid_View }

class ProductByCategoryPage extends StatefulWidget {
  static const String route = "/product_by_category";
  final String categoryId;
  final String categoryName;

  const ProductByCategoryPage(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<ProductByCategoryPage> createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends State<ProductByCategoryPage> {
  late final ProductByCategoryBloc _bloc;
  var viewType = ViewType.List_View;

  int page = 1;
  int size = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ProductInformationEntity> productList;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ProductByCategoryBloc>()
      ..add(ProductByCategoryLoadInformation(
          categoryId: widget.categoryId, page: page, size: size));
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      _bloc.add(ProductByCategoryLoadMoreInformation(
          categoryId: widget.categoryId, page: page, size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<ProductByCategoryBloc, ProductByCategoryState>(
          listener: (context, state) {
            if (state is ProductByCategoryLoadSuccess) {
              viewType = state.viewType;
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              productList = state.products;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.close_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.categoryName,
                style: AppStyle.largeTitleStyleDark,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      NavigationUtil.pushNamed(SearchPage.route);
                    },
                    icon: Icon(
                      Icons.search_rounded,
                      color: AppColor.nonactiveColor,
                    ))
              ],
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(1),
                child: Divider(height: 1),
              ),
            ),
            body: Column(
              children: [
                BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              _bloc.add(const ProductByCategoryChangeViewType(
                                  viewType: ViewType.List_View));
                            },
                            icon: Icon(
                              Icons.menu,
                              color: viewType == ViewType.List_View
                                  ? AppColor.primaryColor
                                  : AppColor.disableColor,
                            )),
                        IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              _bloc.add(ProductByCategoryChangeViewType(
                                  viewType: ViewType.Grid_View));
                            },
                            icon: Icon(Icons.grid_view_sharp,
                                color: viewType == ViewType.Grid_View
                                    ? AppColor.primaryColor
                                    : AppColor.disableColor))
                      ],
                    );
                  },
                ),
                BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
                  builder: (context, state) {
                    if (state is ProductByCategoryLoadInProcess) {
                      return ProductListSkeleton();
                    } else if (state is ProductByCategoryLoadSuccess) {
                      if (productList.isNotEmpty) {
                        return ProductList(
                            viewType: viewType,
                            isLoadingMore: isLoadingMore,
                            cannotLoadMore: cannotLoadMore,
                            productList: productList);
                      } else {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppPath.icCoffee,
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
                      }
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                SizedBox(
                  height: 56,
                )
              ],
            ),
            bottomSheet: ProductByCategoryBottom(),
          ),
        ));
  }
}

Widget ProductList(
    {required ViewType viewType,
    required bool isLoadingMore,
    required bool cannotLoadMore,
    required List<ProductInformationEntity> productList}) {
  if (viewType == ViewType.List_View) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: isLoadingMore ? productList.length + 1 : productList.length,
        itemBuilder: (context, index) => index < productList.length
            ? HomeProduct(
                product: productList[index],
                viewType: ViewType.List_View,
              )
            : const Padding(
                padding: EdgeInsets.all(AppDimen.spacing),
                child: CupertinoActivityIndicator(),
              ),
        separatorBuilder: (context, int index) => Divider(
          height: 8,
          thickness: 0.75,
        ),
      ),
    );
  } else {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  padding: EdgeInsets.zero,
                  itemCount: productList.length,
                  itemBuilder: (context, index) => HomeProduct(
                      product: productList[index],
                      viewType: ViewType.Grid_View)),
            ),
            if (isLoadingMore)
              const Padding(
                padding: EdgeInsets.all(AppDimen.spacing),
                child: CupertinoActivityIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
