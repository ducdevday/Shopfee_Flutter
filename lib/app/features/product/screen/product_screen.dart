import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';
import 'package:shopfee/app/features/product/widgets/note_opt.dart';
import 'package:shopfee/app/features/product/widgets/product_bottom_bar.dart';
import 'package:shopfee/app/features/product/widgets/size_filter.dart';
import 'package:shopfee/app/features/product/widgets/sugar_filter.dart';
import 'package:shopfee/app/features/product/widgets/topping_filter.dart';
import 'package:shopfee/app/features/product/widgets/variant_filter.dart';
import 'package:shopfee/data/models/product.dart';
import 'package:shopfee/data/models/topping.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc _bloc = ProductBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadProduct(widget.product));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 330,
                    color: Color(0xffEFEBE9),
                    child: Center(
                      child: Image.network(
                        widget.product.image,
                        width: 135,
                        height: 240,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 36,
                      right: 12,
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
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          )))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 250),
                padding: EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xffefebe9), width: 1),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.shadowColor,
                                spreadRadius: 0,
                                blurRadius: 1)
                          ]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.product.name,
                                style: AppStyle.largeTitleStyleDark.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.product.priceString,
                                style: AppStyle.largeTitleStyleDark.copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.product.description,
                              style: AppStyle.mediumTextStyleDark.copyWith(
                                  color: AppColor.nonactiveColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: Color(0xffFFB800),
                                  ),
                                  Text(
                                    widget.product.rating.toString(),
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("(23)")
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _bloc.add(DecreaseQuantity());
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(6),
                                      constraints: BoxConstraints(),
                                    ),
                                    BlocBuilder<ProductBloc, ProductState>(
                                      builder: (context, state) {
                                        if (state is ProductLoaded) {
                                          return Container(
                                              width: 32,
                                              height: 32,
                                              color: Colors.white,
                                              alignment: Alignment.center,
                                              child: Text(
                                                  state.order.quantity
                                                      .toString(),
                                                  style: AppStyle
                                                      .largeTitleStyleDark));
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _bloc.add(IncreaseQuantity());
                                      },
                                      icon:
                                          Icon(Icons.add, color: Colors.white),
                                      padding: EdgeInsets.all(6),
                                      constraints: BoxConstraints(),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Color(0xffefebe9), width: 1),
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
                                  style: AppStyle.mediumTextStyleDark.copyWith(
                                      color: AppColor.headingColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Variant",
                                    style: AppStyle.normalTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor)),
                                VariantFilter()
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Size",
                                    style: AppStyle.normalTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor)),
                                SizeFilter()
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Sugar",
                                    style: AppStyle.normalTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor)),
                                SugarFilter()
                              ],
                            )
                          ],
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xffefebe9), width: 1),
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
                                style: AppStyle.mediumTextStyleDark.copyWith(
                                    color: AppColor.headingColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          ToppingFilter(
                            toppings: Topping.toppings,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xffefebe9), width: 1),
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
                                style: AppStyle.mediumTextStyleDark.copyWith(
                                    color: AppColor.headingColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          NoteOpt(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: ProductBottomBar(),
      ),
    );
  }
}
