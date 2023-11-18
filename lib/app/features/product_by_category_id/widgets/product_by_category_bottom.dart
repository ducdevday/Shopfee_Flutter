import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';

class ProductByCategoryBottom extends StatelessWidget {
  const ProductByCategoryBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          // if (state.cart.orders.isEmpty) {
          //   return SizedBox();
          // }
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, AppRouter.cartRoute);
            },
            child: Container(
              width: double.infinity,
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: AppDimen.spacing),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
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
                        Visibility(
                          visible: state.cart.nameOrderString.isEmpty ? false : true,
                          maintainSize: state.cart.nameOrderString.isEmpty ? false : true,
                          maintainAnimation: state.cart.nameOrderString.isEmpty ? false : true,
                          maintainState: state.cart.nameOrderString.isEmpty ? false : true,
                          child: Text(
                            state.cart.nameOrderString,
                            style: AppStyle.smallTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
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
