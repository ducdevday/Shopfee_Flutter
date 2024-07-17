part of home;

class HomePage extends StatefulWidget {
  static const int indexPage = 0;

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;
  late final RefreshController _refreshController;

  final homeItemType = ValueNotifier<HomeItemView>(HomeItemView.TOP_RATED);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void handleMenuClick(HomeItemView type) {
    homeItemType.value = type;
  }

  List<ProductInformationEntity> listHomeItem(
      HomeItemView value, HomeLoadSuccess state) {
    switch (value) {
      case HomeItemView.TOP_RATED:
        return state.outstandingProducts;
      case HomeItemView.BEST_SELLING:
        return state.topSellingProducts;
      case HomeItemView.VIEWED:
        return state.viewedProducts;
      default:
        return [];
    }
  }

  String getHomeItemName(HomeItemView value) {
    switch (value) {
      case HomeItemView.TOP_RATED:
        return R.topRated.tr();
      case HomeItemView.BEST_SELLING:
        return R.bestSelling.tr();
      case HomeItemView.VIEWED:
        return R.viewed.tr();
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshConfiguration.copyAncestor(
        context: context,
        child: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              SliverAppBar(
                snap: true,
                automaticallyImplyLeading: false,
                floating: true,
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
                      //TODO: Notify Icon
                      // const SizedBox(width: 10),
                      // Hero(
                      //     tag: "Home_Action",
                      //     child: const Icon(Icons.notifications_none_outlined))
                    ],
                  ),
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                ),
              )
            ];
          },
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadInProcess) {
                return const HomeSkeleton();
              } else if (state is HomeLoadSuccess) {
                return SmartRefresher(
                  controller: _refreshController,
                  enablePullUp: false,
                  physics: BouncingScrollPhysics(),
                  onRefresh: () async {
                    //monitor fetch data from network
                    context.read<HomeBloc>().add(HomeRefreshInformation());
                    // if (mounted) setState(() {});
                    _refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    //monitor fetch data from network
                    await Future.delayed(Duration(milliseconds: 180));
                    // if (mounted) setState(() {});
                    _refreshController.loadFailed();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: AppDimen.spacing,
                        ),
                        const HomeSlider(),
                        const SizedBox(
                          height: AppDimen.spacing,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 80,
                              child: Scrollbar(
                                thickness: 1,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) => InkWell(
                                          onTap: () {
                                            NavigationUtil.pushNamed(
                                                ProductByCategoryPage.route,
                                                arguments: {
                                                  "categoryId": state
                                                      .categories[index].id,
                                                  "categoryName": state
                                                      .categories[index].name!
                                                });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: AppDimen.spacing),
                                            child: Column(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: state
                                                      .categories[index].image!,
                                                  width:
                                                      AppDimen.smallImageSize,
                                                  height:
                                                      AppDimen.smallImageSize,
                                                  placeholder: (context, url) =>
                                                      MyPlaceHolderRectangle(
                                                    width:
                                                        AppDimen.smallImageSize,
                                                    height:
                                                        AppDimen.smallImageSize,
                                                  ),
                                                  errorWidget: (_, __, ___) =>
                                                      Image.asset(
                                                    AppPath.imgImageError,
                                                    width:
                                                        AppDimen.smallImageSize,
                                                    height:
                                                        AppDimen.smallImageSize,
                                                  ),
                                                ),
                                                Text(
                                                  state.categories[index].name!,
                                                  style: AppStyle
                                                      .mediumTextStyleDark,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(),
                                    itemCount: state.categories.length),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            if (state.newestBlogs.isNotEmpty)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: AppDimen.screenPadding),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          R.blogPost.tr(),
                                          style: AppStyle.mediumTitleStyleDark,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            NavigationUtil.pushNamed(
                                                BlogPage.route);
                                          },
                                          child: Text(
                                            R.seeMore.tr(),
                                            style:
                                                AppStyle.normalTextStylePrimary,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    height: 240,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppDimen.screenPadding),
                                      itemCount: state.newestBlogs.length,
                                      itemBuilder: (context, index) => HomeBlog(
                                          blog: state.newestBlogs[index]),
                                      separatorBuilder: (context, int index) =>
                                          const SizedBox(
                                        width: AppDimen.spacing,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            // if (state.topSellingProducts.isNotEmpty)
                            //   Column(
                            //     children: [
                            //       Padding(
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: AppDimen.screenPadding),
                            //         child: Align(
                            //           alignment: Alignment.centerLeft,
                            //           child: Text(
                            //             "Top Selling",
                            //             style: AppStyle.mediumTitleStyleDark,
                            //           ),
                            //         ),
                            //       ),
                            //       const SizedBox(
                            //         height: 8,
                            //       ),
                            //       SizedBox(
                            //         height: 180,
                            //         child: ListView.separated(
                            //           scrollDirection: Axis.horizontal,
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: AppDimen.screenPadding),
                            //           itemCount:
                            //               state.topSellingProducts.length,
                            //           itemBuilder: (context, index) =>
                            //               HomeProduct(
                            //             product:
                            //                 state.topSellingProducts[index],
                            //             viewType: ProductViewType
                            //                 .List_View_Horizontal,
                            //           ),
                            //           separatorBuilder: (context, int index) =>
                            //               const SizedBox(
                            //             width: AppDimen.spacing,
                            //           ),
                            //         ),
                            //       ),
                            //       const SizedBox(
                            //         height: 16,
                            //       ),
                            //     ],
                            //   ),
                            ValueListenableBuilder(
                              valueListenable: homeItemType,
                              builder: (BuildContext context,
                                  HomeItemView homeItemTypeValue,
                                  Widget? child) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppDimen.screenPadding),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              getHomeItemName(
                                                  homeItemTypeValue),
                                              style:
                                                  AppStyle.mediumTitleStyleDark,
                                            ),
                                            PopupMenuButton<HomeItemView>(
                                              icon:
                                                  Icon(Icons.menu_open_rounded),
                                              onSelected: handleMenuClick,
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return HomeItemView.values
                                                    .map((e) {
                                                  return PopupMenuItem<
                                                      HomeItemView>(
                                                    value: e,
                                                    child: Text(
                                                        getHomeItemName(e)),
                                                  );
                                                }).toList();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (listHomeItem(homeItemTypeValue, state)
                                        .isNotEmpty)
                                      ListView.separated(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: listHomeItem(
                                                homeItemTypeValue, state)
                                            .length,
                                        itemBuilder: (context, index) =>
                                            HomeProduct(
                                          product: listHomeItem(
                                              homeItemTypeValue, state)[index],
                                          viewType: ProductViewType
                                              .List_View_Vertical,
                                        ),
                                        separatorBuilder:
                                            (context, int index) =>
                                                const Divider(
                                          height: 8,
                                          thickness: 0.75,
                                        ),
                                      ),
                                    if (listHomeItem(homeItemTypeValue, state)
                                        .isEmpty)
                                      SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
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
                                              style: AppStyle
                                                  .mediumTextStyleDark
                                                  .copyWith(
                                                      color: AppColor
                                                          .nonactiveColor),
                                            )
                                          ],
                                        ),
                                      )
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 68,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return const MyErrorPage();
              }
            },
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: const HomeFloatAction(),
    );
  }
}

enum HomeItemView { TOP_RATED, BEST_SELLING, VIEWED }
