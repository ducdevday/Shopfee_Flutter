import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              context.read<ProductBloc>().add(DecreaseQuantity());
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
                    child: Text(state.order.quantity.toString(),
                        style: AppStyle.largeTitleStyleDark));
              } else {
                return SizedBox();
              }
            },
          ),
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              context.read<ProductBloc>().add(IncreaseQuantity());
            },
            icon: Icon(Icons.add, color: Colors.white),
            padding: EdgeInsets.all(6),
            constraints: BoxConstraints(),
          )
        ],
      ),
    );
  }
}
