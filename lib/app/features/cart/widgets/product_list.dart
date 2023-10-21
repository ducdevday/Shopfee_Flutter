import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/cart/widgets/cart_item.dart';
import 'package:shopfee/app/features/cart/widgets/edit_order_bottom_sheet.dart';
import 'package:shopfee/data/models/order.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late int defaultLength = 3;
  late int maxLength = 3;
  late int productListLength;
  late String defaultText = "Show more";
  late Icon defaultIcon = Icon(Icons.keyboard_arrow_down_rounded);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          productListLength = state.cart.orders.length;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product list",
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productListLength < defaultLength ? productListLength :maxLength,
                      itemBuilder: (context, index) {
                        return CartItem(
                            index: index,
                            callback: () {
                              buildShowEditOrderBottomSheet(
                                  context, state.cart.orders[index], index);
                            });
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 15,
                        );
                      },
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.keyboard_arrow_left_rounded),
                        label: Text(
                          "Add more product",
                          style: AppStyle.normalTextStylePrimary
                              .copyWith(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (defaultLength < productListLength) {
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Divider(height: 1,),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () {
                            if (maxLength == 3) {
                              setState(() {
                                maxLength = productListLength;
                                defaultText = "Show less";
                                defaultIcon = Icon(Icons.keyboard_arrow_up_rounded);
                              });
                            } else {
                              setState(() {
                                maxLength = 3;
                                defaultText = "Show more";
                                defaultIcon = Icon(Icons.keyboard_arrow_down_rounded);
                              });
                            }
                          },
                          label: Text(defaultText),
                          icon: defaultIcon,
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              })
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
  Future<void> buildShowEditOrderBottomSheet(
      BuildContext context, Order order, int index) {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (BuildContext context) {
          return EditOrderBottomSheet(order: order, index: index);
        });
  }
}