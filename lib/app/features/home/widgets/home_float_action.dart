import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';

class HomeFloatAction extends StatelessWidget {
  const HomeFloatAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orders.isEmpty) {
            return SizedBox();
          }
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/cart");
            },
            child: Container(
              width: double.infinity,
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.cart.quantityTotalString,
                          style: AppStyle.mediumTitleStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          state.cart.nameOrderString,
                          style: AppStyle.smallTextStyle,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(state.cart.totalPriceString,
                          style: AppStyle.mediumTitleStyle
                              .copyWith(fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset("assets/icons/ic_shopping_bag.svg")
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
