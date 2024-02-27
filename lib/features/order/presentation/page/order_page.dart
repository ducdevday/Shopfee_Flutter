part of order;

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  // late final OrderBloc context.read<OrderBloc>();

  int page = 1;
  int size = 8;
  bool isLoadingMore = false;
  bool cannotLoadMore = false;
  ViewType viewType = ViewType.List_View;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (isLoadingMore || cannotLoadMore) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      context
          .read<OrderBloc>()
          .add(OrderLoadInformation(page: page, size: size));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: TextField(
                    enabled: false,
                    style: AppStyle.smallTextStyleDark,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: "What would you like to drink today?",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.notifications_none_outlined)
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
                    return ProductList(
                        viewType: viewType,
                        isLoadingMore: isLoadingMore,
                        cannotLoadMore: cannotLoadMore,
                        productList: state.products);
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
                        context.read<OrderBloc>().add(const OrderChangeViewType(
                            viewType: ViewType.Grid_View));
                      },
                      icon: Icon(Icons.grid_view_sharp,
                          color: viewType == ViewType.Grid_View
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
                          page = 1;
                          isLoadingMore = false;
                          cannotLoadMore = false;
                          context.read<OrderBloc>().add(OrderChooseCategory(
                              category: state.categories[index],
                              page: page,
                              size: size));
                        }
                      },
                      child: Column(
                        children: [
                          Image(
                            image:
                                NetworkImage(state.categories[index].image!),
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(
                            width: 60,
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
                            color: state.chosenCategory ==
                                state.categories[index]
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
