part of home;

class HomePage extends StatefulWidget {
  static const int indexPage = 0;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
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
                              hintText: "What would you like to drink today?",
                            ),
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
            )
          ];
        },
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadInProcess) {
              return const HomeSkeleton();
            } else if (state is HomeLoadSuccess) {
              return SingleChildScrollView(
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
                                              "categoryId":
                                                  state.categories[index].id,
                                              "categoryName":
                                                  state.categories[index].name!
                                            });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: AppDimen.spacing),
                                        child: Column(
                                          children: [
                                            Image(
                                              image: NetworkImage(state
                                                  .categories[index].image!),
                                              width: 60,
                                              height: 60,
                                            ),
                                            Text(
                                              state.categories[index].name!,
                                              style:
                                                  AppStyle.mediumTextStyleDark,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimen.screenPadding),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Top Selling",
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 180,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                            itemCount: state.topSellingProducts.length,
                            itemBuilder: (context, index) => HomeProduct(
                              product: state.topSellingProducts[index],
                              viewType: ProductViewType.List_View_Horizontal,
                            ),
                            separatorBuilder: (context, int index) =>
                            const SizedBox(
                              width: AppDimen.spacing,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppDimen.screenPadding),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Outstanding Products",
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.outstandingProducts.length,
                          itemBuilder: (context, index) => HomeProduct(
                            product: state.outstandingProducts[index],
                            viewType: ProductViewType.List_View_Vertical,
                          ),
                          separatorBuilder: (context, int index) =>
                              const Divider(
                            height: 8,
                            thickness: 0.75,
                          ),
                        ),
                        const SizedBox(
                          height: 68,
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return const MyErrorPage();
            }
          },
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: const HomeFloatAction(),
    );
  }
}
