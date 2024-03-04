part of home;

class HomePage extends StatelessWidget {
  static const int indexPage = 0;
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
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
            )
          ];
        },
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadInProcess) {
              return HomeSkeleton();
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
                        Container(
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
                          itemCount: state.products.length,
                          itemBuilder: (context, index) => HomeProduct(
                            product: state.products[index],
                            viewType: ViewType.List_View,
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
              return MyErrorPage();
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
