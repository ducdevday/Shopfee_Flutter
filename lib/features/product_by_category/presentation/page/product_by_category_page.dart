part of product_by_category;

class ProductByCategoryPage extends StatefulWidget {
  static const String route = "/product_by_category";
  final String? categoryId;
  final String categoryName;

  const ProductByCategoryPage(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<ProductByCategoryPage> createState() => _ProductByCategoryPageState();
}

class _ProductByCategoryPageState extends State<ProductByCategoryPage> {
  late final ProductByCategoryBloc _bloc;
  var viewType = ProductViewType.List_View_Vertical;

  int page = 1;
  int size = 8;
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ProductInformationEntity> productList;
  late ScrollController scrollController;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ProductByCategoryBloc>()
      ..add(ProductByCategoryLoadInformation(
          categoryId: widget.categoryId, page: page, size: size));
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _bloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _bloc.add(ProductByCategoryLoadMoreInformation());
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
          child: RefreshConfiguration.copyAncestor(
            context: context,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.close_rounded),
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
                                    viewType:
                                        ProductViewType.List_View_Vertical));
                              },
                              icon: Icon(
                                Icons.menu,
                                color: viewType ==
                                        ProductViewType.List_View_Vertical
                                    ? AppColor.primaryColor
                                    : AppColor.disableColor,
                              )),
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                _bloc.add(const ProductByCategoryChangeViewType(
                                    viewType: ProductViewType.Grid_View));
                              },
                              icon: Icon(Icons.grid_view_sharp,
                                  color: viewType == ProductViewType.Grid_View
                                      ? AppColor.primaryColor
                                      : AppColor.disableColor))
                        ],
                      );
                    },
                  ),
                  BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
                    builder: (context, state) {
                      if (state is ProductByCategoryLoadInProcess) {
                        return const ProductListSkeleton();
                      } else if (state is ProductByCategoryLoadSuccess) {
                        if (productList.isNotEmpty) {
                          return Expanded(
                            child: SmartRefresher(
                              controller: _refreshController,
                              enablePullUp: false,
                              physics: BouncingScrollPhysics(),
                              onRefresh: () async {
                                context.read<ProductByCategoryBloc>().add(
                                    ProductByCategoryRefreshInformation(
                                        page: page, size: size));
                                _refreshController.refreshCompleted();
                              },
                              child: ProductList(
                                viewType: viewType,
                                isLoadingMore: isLoadingMore,
                                cannotLoadMore: cannotLoadMore,
                                productList: productList,
                                scrollController: scrollController,
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppPath.icNoProduct,
                                  width: 60,
                                  height: 60,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  R.noProductFound.tr(),
                                  style: AppStyle.mediumTextStyleDark
                                      .copyWith(color: AppColor.nonactiveColor),
                                )
                              ],
                            ),
                          );
                        }
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 56,
                  )
                ],
              ),
              bottomSheet: const ProductByCategoryBottom(),
            ),
          ),
        ));
  }
}

Widget ProductList(
    {required ScrollController scrollController,
    required ProductViewType viewType,
    required bool isLoadingMore,
    required bool cannotLoadMore,
    required List<ProductInformationEntity> productList}) {
  if (viewType == ProductViewType.List_View_Vertical) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.only(
          bottom: 68),
      itemCount: isLoadingMore ? productList.length + 1 : productList.length,
      itemBuilder: (context, index) => index < productList.length
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
  } else {
    return GridView.builder(
        controller: scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        padding: const EdgeInsets.only(
            left: AppDimen.screenPadding,
            right: AppDimen.screenPadding,
            bottom: 68),
        itemCount: productList.length,
        itemBuilder: (context, index) => HomeProduct(
            product: productList[index], viewType: ProductViewType.Grid_View));
  }
}
