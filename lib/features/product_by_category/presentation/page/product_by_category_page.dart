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

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ProductByCategoryBloc>()
      ..add(ProductByCategoryLoadInformation(categoryId: widget.categoryId));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<ProductByCategoryBloc, ProductByCategoryState>(
          listener: (context, state) {
            if (state is ProductByCategoryLoadSuccess) {
              viewType = state.viewType;
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
                      return ProductList(context, state);
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
    BuildContext buildContext, ProductByCategoryLoadSuccess state) {
  if (state.viewType == ViewType.List_View) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: state.products.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            NavigationUtil.pushNamed(ProductDetailPage.route,
                arguments: state.products[index].id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: AppDimen.screenPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: const BoxDecoration(
                        color: Color(0xfff4f4f3),
                        shape: BoxShape.circle,
                        // image: DecorationImage(image: NetworkImage(product.imageUrl,),fit: BoxFit.cover)
                      ),
                    ),
                    Image.network(
                      state.products[index].imageUrl,
                      height: 68,
                      width: 58,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.products[index].name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.mediumTextStyleDark
                                .copyWith(color: Color(0xff555555))),
                        SizedBox(
                          height: 4,
                        ),
                        Text(state.products[index].description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.normalTextStyleDark
                                .copyWith(color: Color(0xff555555))),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    FormatUtil.formatMoney(state.products[index].price),
                    style: AppStyle.mediumTextStyleDark
                        .copyWith(color: AppColor.headingColor),
                  ),
                )
              ],
            ),
          ),
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
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
            padding: EdgeInsets.zero,
            itemCount: state.products.length,
            itemBuilder: (context, index) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ProductScreen(state.products[index].id)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        side: BorderSide(color: Color(0xfff5f5f5), width: 2)),
                    elevation: 0.25,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              state.products[index].imageUrl,
                              height: 88,
                              width: 68,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(state.products[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.mediumTextStyleDark.copyWith(
                                      color: Color(0xff555555), height: 1.5)),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  FormatUtil.formatMoney(
                                      state.products[index].price),
                                  style: AppStyle.mediumTextStyleDark.copyWith(
                                      color: AppColor.headingColor,
                                      height: 1.2)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
