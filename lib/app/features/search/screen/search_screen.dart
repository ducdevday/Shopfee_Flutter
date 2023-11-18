import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/home/widgets/home_product.dart';
import 'package:shopfee/app/features/search/cubit/search_cubit.dart';
import 'package:shopfee/data/models/product_information.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchCubit _cubit;
  final scrollController = ScrollController();
  late bool isLoadingMore;
  late bool cannotLoadMore;
  late List<ProductInformation> productList;

  @override
  void initState() {
    super.initState();
    _cubit = SearchCubit(productRepository: context.read<ProductRepository>());
    scrollController.addListener(_scrollListener);
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
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      style: AppStyle.smallTextStyleDark,
                      onChanged: (value) => _cubit.searchProduct(value),
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
                          borderSide: BorderSide(color: Color(0xffCCCCCC)),
                        ),
                        hintText: "What would you like to drink today?",
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   splashColor: Colors.transparent,
                  //   highlightColor: Colors.transparent,
                  //   constraints: BoxConstraints(),
                  //   icon: Icon(Icons.arrow_back_outlined),
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  // ),
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
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
          ),
          body: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                isLoadingMore = state.isLoadMore;
                cannotLoadMore = state.cannotLoadMore;
                productList = state.products;
                if (productList.isNotEmpty && state.query.isNotEmpty) {
                  return ListView.separated(
                    controller: scrollController,
                    padding: EdgeInsets.only(top: AppDimen.screenPadding),
                    itemCount: isLoadingMore
                        ? productList.length + 1
                        : productList.length,
                    itemBuilder: (context, index) => index < productList.length
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppDimen.screenPadding),
                            child: HomeProduct(state.products[index]))
                        : const Padding(
                            padding: EdgeInsets.all(AppDimen.spacing),
                            child: CupertinoActivityIndicator(),
                          ),
                    separatorBuilder: (context, int index) => const Divider(
                      height: 8,
                      thickness: 0.75,
                    ),
                  );
                } else if (state.query.isNotEmpty) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/ic_coffee.png",
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
                } else {
                  return SizedBox();
                }
              } else {
                return SizedBox();
              }
            },
          ),
        ));
  }
}
