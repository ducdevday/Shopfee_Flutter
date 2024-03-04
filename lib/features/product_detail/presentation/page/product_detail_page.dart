import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:shopfee/core/common/enum/product_status.dart';
import 'package:shopfee/core/common/widgets/my_error_page.dart';
import 'package:shopfee/core/common/widgets/my_loading_page.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';

class ProductDetailPage extends StatefulWidget {
  static const String route = "/product_detail";
  final String productId;

  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ProductDetailBloc>()
      ..add(ProductDetailLoadInformation(widget.productId));
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
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoadInProcess) {
            return const MyLoadingPage();
          } else if (state is ProductDetailLoadSuccess) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 330,
                      color: const Color(0xffEFEBE9),
                      child: Center(
                        child: Image.network(
                          state.order.product.imageUrl!,
                          width: 165,
                          height: 270,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 250),
                      padding: const EdgeInsets.all(AppDimen.screenPadding),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xffefebe9), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.shadowColor,
                                      spreadRadius: 0,
                                      blurRadius: 1)
                                ]),
                            child: BlocBuilder<ProductDetailBloc,
                                ProductDetailState>(
                              builder: (context, state) {
                                if (state is ProductDetailLoadSuccess) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.order.product.name!,
                                            style: AppStyle.largeTitleStyleDark
                                                .copyWith(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          Text(
                                            FormatUtil.formatMoney(
                                                state.order.size!.price),
                                            style: AppStyle.largeTitleStyleDark
                                                .copyWith(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: ReadMoreText(
                                            state.order.product.description!,
                                            style: AppStyle.mediumTextStyleDark
                                                .copyWith(
                                                    color:
                                                        AppColor.nonactiveColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                            trimLines: 2,
                                            trimMode: TrimMode.Line,
                                            colorClickableText:
                                                AppColor.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xffFFB800),
                                                ),
                                                Text(
                                                  "${state.order.product.ratingSummary?.star}/5",
                                                  style: AppStyle
                                                      .mediumTextStyleDark
                                                      .copyWith(
                                                          color: AppColor
                                                              .headingColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "(${state.order.product.ratingSummary?.quantity})",
                                                  style: TextStyle(
                                                      color: AppColor.info),
                                                )
                                              ],
                                            ),
                                          ),
                                          ProductQuantity()
                                        ],
                                      )
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color(0xffefebe9), width: 1),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColor.shadowColor,
                                        spreadRadius: 0,
                                        blurRadius: 1)
                                  ]),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text("Customize",
                                        style: AppStyle.mediumTextStyleDark
                                            .copyWith(
                                                color: AppColor.headingColor,
                                                fontWeight: FontWeight.bold)),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Size",
                                          style: AppStyle.normalTextStyleDark
                                              .copyWith(
                                                  color:
                                                      AppColor.headingColor)),
                                      const SizeFilter()
                                    ],
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xffefebe9), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.shadowColor,
                                      spreadRadius: 0,
                                      blurRadius: 1)
                                ]),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Topping",
                                      style: AppStyle.mediumTextStyleDark
                                          .copyWith(
                                              color: AppColor.headingColor,
                                              fontWeight: FontWeight.bold)),
                                ),
                                ToppingFilter()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: const Color(0xffefebe9), width: 1),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.shadowColor,
                                      spreadRadius: 0,
                                      blurRadius: 1)
                                ]),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Note",
                                      style: AppStyle.mediumTextStyleDark
                                          .copyWith(
                                              color: AppColor.headingColor,
                                              fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const NoteOpt(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state.order.product.status ==
                        ProductStatus.OUT_OF_STOCK)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(
                                0.5), // Adjust opacity and color as needed
                          ),
                        ),
                      ),
                    Positioned(
                        top: 36,
                        left: AppDimen.screenPadding,
                        child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColor.disableColor,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              iconSize: 16,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                              ),
                            ))),
                    if (state.order.product.status ==
                        ProductStatus.OUT_OF_STOCK)
                    Positioned(
                        top: 36,
                        right: AppDimen.screenPadding,
                        child: Image.asset(
                          AppPath.imgSoldOut2,
                          width: 100,
                        )),
                  ],
                ),
              ),
              bottomNavigationBar: const ProductBottomBar(),
            );
          } else {
            return const MyErrorPage();
          }
        },
      ),
    );
  }
}
