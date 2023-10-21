import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return BottomAppBar(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: AppStyle.normalTextStyleDark,
                      ),
                      Text(
                        state.order.totalString,
                        style: AppStyle.largeTitleStyleDark,
                      )
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>()..add(AddItemIntoCart(order: state.order));
                        Navigator.pop(context);
                      },
                      style: AppStyle.elevatedButtonStylePrimary,
                      child: const Text("Add To Cart"))
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
