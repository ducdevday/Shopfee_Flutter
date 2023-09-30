import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';

class BoughtList extends StatelessWidget {
  const BoughtList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Bought list",
              style: AppStyle.mediumTitleStyleDark
                  .copyWith(
                  color:
                  AppColor.headingColor,
                  fontWeight:
                  FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics:
                  NeverScrollableScrollPhysics(),
                  itemCount:
                  state.cart.orders.length,
                  itemBuilder: (context, index) {
                    return BoughtItem(
                        index: index);
                  },
                  separatorBuilder:
                      (BuildContext context,
                      int index) {
                    return Divider(
                      height: 10,
                    );
                  },
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
class BoughtItem extends StatelessWidget {
  final int index;

  const BoughtItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.cart.orders[index].product.name,
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        state.cart.orders[index].size.toString().split(".")[1],
                        style: AppStyle.normalTextStyleDark,
                      ),
                      state.cart.orders[index].toppings.isNotEmpty
                          ? Text(state.cart.orders[index].toppingOrderString,
                          style: AppStyle.normalTextStyleDark)
                          : SizedBox(),
                      state.cart.orders[index].toppings.isNotEmpty
                          ? Row(
                        children: [
                          Icon(
                            Icons.sticky_note_2_outlined,
                            color: AppColor.primaryColor,
                            size: 18,
                          ),
                          Expanded(
                            child: Text(
                              state.cart.orders[index].note,
                              style: AppStyle.normalTextStyleDark,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                          : SizedBox()
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(state.cart.orders[index].totalString,
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor)),
                      SizedBox(
                        height: 6,
                      ),
                      Text("x${state.cart.orders[index].quantity}",
                          style: AppStyle.normalTextStyleDark)
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
