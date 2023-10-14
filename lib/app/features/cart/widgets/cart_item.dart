import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';

class CartItem extends StatelessWidget {
  final int index;
  final VoidCallback callback;

  const CartItem({Key? key, required this.index, required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return IntrinsicHeight(
            child: Row(
              children: [
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      callback();
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/ic_edit.svg",
                      color: AppColor.primaryColor,
                    ),
                    label: Text(
                      "Edit",
                      style: AppStyle.mediumTitleStyleDark
                          .copyWith(color: AppColor.primaryColor, fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${state.cart.orders[index].quantity}x ${state.cart.orders[index].product.name!}",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(color: AppColor.headingColor).copyWith(fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        state.cart.orders[index].size!.size,
                        style: AppStyle.normalTextStyleDark,
                      ),
                      state.cart.orders[index].toppings.isNotEmpty
                          ? Text(state.cart.orders[index].toppingOrderString,
                              style: AppStyle.normalTextStyleDark)
                          : SizedBox(),
                      state.cart.orders[index].note.isNotEmpty
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
