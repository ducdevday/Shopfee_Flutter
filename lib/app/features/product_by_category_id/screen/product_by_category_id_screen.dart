import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/common/widgets/my_error.dart';
import 'package:shopfee/app/common/widgets/my_loading.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/screen/product_screen.dart';
import 'package:shopfee/app/features/product_by_category_id/bloc/product_by_category_id_bloc.dart';
import 'package:shopfee/app/features/product_by_category_id/widgets/product_by_category_bottom.dart';
import 'package:shopfee/app/features/product_by_category_id/widgets/product_list_skeleton.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

class ProductByCategoryIdScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const ProductByCategoryIdScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProductByCategoryIdBloc(
            productRepository: context.read<ProductRepository>())
          ..add(LoadProduct(categoryId: categoryId)),
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
              categoryName,
              style: AppStyle.largeTitleStyleDark,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouter.searchRoute);
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                BlocBuilder<ProductByCategoryIdBloc, ProductByCategoryIdState>(
                  buildWhen: (previousState, state) =>
                      state is! ProductByCategoryLoading,
                  builder: (context, state) {
                    if (state is ProductByCategoryLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                context.read<ProductByCategoryIdBloc>().add(
                                    ChangeViewTypeProduct(
                                        viewType: ViewType.List_View));
                              },
                              icon: Icon(
                                Icons.menu,
                                color: state.viewType == ViewType.List_View
                                    ? AppColor.primaryColor
                                    : AppColor.disableColor,
                              )),
                          IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                context.read<ProductByCategoryIdBloc>().add(
                                    ChangeViewTypeProduct(
                                        viewType: ViewType.Grid_View));
                              },
                              icon: Icon(Icons.grid_view_sharp,
                                  color: state.viewType == ViewType.Grid_View
                                      ? AppColor.primaryColor
                                      : AppColor.disableColor))
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                BlocBuilder<ProductByCategoryIdBloc, ProductByCategoryIdState>(
                  builder: (context, state) {
                    if (state is ProductByCategoryLoading) {
                      return ProductListSkeleton();
                    } else if (state is ProductByCategoryLoaded) {
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
          ),
          bottomSheet: ProductByCategoryBottom(),
        ));
  }
}

Widget ProductList(BuildContext buildContext, ProductByCategoryLoaded state) {
  if (state.viewType == ViewType.List_View) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: state.products.length,
        itemBuilder: (context, index) => Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRouter.productRoute,
                    arguments: state.products[index].id);
              },
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
                      state.products[index].priceString,
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.headingColor),
                    ),
                  )
                ],
              ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductScreen(state.products[index].id)));
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
                              child: Text(state.products[index].priceString,
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
