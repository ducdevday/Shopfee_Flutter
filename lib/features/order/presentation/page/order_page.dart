part of order;

class OrderPage extends StatefulWidget {
  static const int indexPage = 1;

  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // late final OrderBloc context.read<OrderBloc>();

  int initPage = 1;
  int initSize = 8;
  bool isLoadingMore = false;
  bool cannotLoadMore = false;
  ProductViewType viewType = ProductViewType.List_View_Vertical;
  late ScrollController scrollController;
  late RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context.read<OrderBloc>().add(OrderLoadMoreInformation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration.copyAncestor(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      NavigationUtil.pushNamed(SearchPage.route);
                    },
                    child: Hero(
                      tag: "Home_Search_Bar",
                      child: TextField(
                        enabled: false,
                        style: AppStyle.smallTextStyleDark,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          hintText: R.homeSearchBar.tr(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoadSuccess) {
                      return Badge(
                          label: Text("${state.filterNumber}"),
                          isLabelVisible: state.filterNumber != 0,
                          child: GestureDetector(
                              onTap: () {
                                buildShowFilterBottomSheet(context);
                              },
                              child: Icon(Icons.filter_alt_outlined)));
                    } else {
                      return Icon(Icons.filter_alt_outlined);
                    }
                  },
                ),
                const SizedBox(width: 10),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    if (state is OrderLoadSuccess) {
                      return Badge(
                          label: Text("${state.sortNumber}"),
                          isLabelVisible: state.sortNumber != 0,
                          child: GestureDetector(
                              onTap: () {
                                buildShowSortBottomSheet(context);
                              },
                              child: Icon(Icons.sort_rounded)));
                    } else {
                      return Icon(Icons.sort_rounded);
                    }
                  },
                )
              ],
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          ),
        ),
        body: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderLoadSuccess) {
              isLoadingMore = state.isLoadMore;
              cannotLoadMore = state.cannotLoadMore;
              viewType = state.viewType;
            }
          },
          child: Column(
            children: [
              const SizedBox(
                height: AppDimen.spacing,
              ),
              buildCategoryList(),
              buildViewType(),
              BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
                switch (state) {
                  case OrderLoadInProcess():
                    return ProductListSkeleton();
                  case OrderLoadSuccess():
                    if (state.products.isNotEmpty) {
                      return Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullUp: false,
                          physics: BouncingScrollPhysics(),
                          onRefresh: () async {
                            context.read<OrderBloc>().add(
                                OrderRefreshInformation(
                                    initPage: initPage, initSize: initSize));
                            _refreshController.refreshCompleted();
                          },
                          child: ProductList(
                              scrollController: scrollController,
                              viewType: viewType,
                              isLoadingMore: isLoadingMore,
                              cannotLoadMore: cannotLoadMore,
                              productList: state.products),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: MyEmptyList(
                          imgPath: AppPath.icNoProduct,
                          text: R.noResultFound.tr(),
                        ),
                      );
                    }
                  case OrderLoadFailure():
                    return MyErrorWidget();
                  default:
                    return SizedBox();
                }
              }),
            ],
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: const HomeFloatAction(),
      ),
    );
  }

  Widget buildViewType() {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimen.spacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoadSuccess) {
                  return Text(
                    state.chosenCategory?.name ?? "",
                    style: AppStyle.mediumTitleStyleDark,
                  );
                }
                return SizedBox();
              },
            ),
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        context.read<OrderBloc>().add(const OrderChangeViewType(
                            viewType: ProductViewType.List_View_Vertical));
                      },
                      icon: Icon(
                        Icons.menu,
                        color: viewType == ProductViewType.List_View_Vertical
                            ? AppColor.primaryColor
                            : AppColor.disableColor,
                      )),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        context.read<OrderBloc>().add(const OrderChangeViewType(
                            viewType: ProductViewType.Grid_View));
                      },
                      icon: Icon(Icons.grid_view_sharp,
                          color: viewType == ProductViewType.Grid_View
                              ? AppColor.primaryColor
                              : AppColor.disableColor))
                ],
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildCategoryList() {
    return BlocBuilder<OrderBloc, OrderState>(
      buildWhen: (preState, state) {
        if (preState is OrderLoadSuccess &&
            state is OrderLoadSuccess &&
            preState.chosenCategory == state.chosenCategory) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is OrderLoadSuccess) {
          return SizedBox(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (state.chosenCategory != state.categories[index]) {
                          isLoadingMore = false;
                          cannotLoadMore = false;
                          context.read<OrderBloc>().add(OrderSelectCategory(
                                category: state.categories[index],
                                initPage: initPage,
                                initSize: initSize,
                              ));
                        }
                      },
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: state.categories[index].image!,
                            fit: BoxFit.cover,
                            width: AppDimen.smallImageSize,
                            height: AppDimen.smallImageSize,
                            placeholder: (context, url) =>
                                MyPlaceHolderRectangle(
                              width: AppDimen.smallImageSize,
                              height: AppDimen.smallImageSize,
                            ),
                            errorWidget: (_, __, ___) => Image.asset(
                              AppPath.imgImageError,
                              width: AppDimen.smallImageSize,
                              height: AppDimen.smallImageSize,
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              state.categories[index].name!,
                              style: AppStyle.mediumTextStyleDark
                                  .copyWith(height: 1.5),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                          ),
                          Container(
                            height: 1.5,
                            width: 100,
                            color:
                                state.chosenCategory == state.categories[index]
                                    ? AppColor.primaryColor
                                    : Colors.transparent,
                          )
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: state.categories.length),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

Future<bool?> buildShowFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet<bool?>(
    backgroundColor: Colors.black.withOpacity(0.75),
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<OrderBloc>(),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadSuccess) {
              return OrderFilterBottomSheet(
                branchId: state.branchId,
                minPrice: state.minPrice,
                maxPrice: state.maxPrice,
                minStar: state.minStar,
              );
            } else {
              return SizedBox();
            }
          },
        ),
      );
    },
  );
}

Future<bool?> buildShowSortBottomSheet(BuildContext context) {
  return showModalBottomSheet<bool?>(
    backgroundColor: Colors.black.withOpacity(0.75),
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<OrderBloc>(),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadSuccess) {
              return OrderSortBottomSheet(
                sortType: state.sortType,
              );
            } else {
              return SizedBox();
            }
          },
        ),
      );
    },
  );
}
