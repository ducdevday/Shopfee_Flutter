import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';

class SizeFilter extends StatelessWidget {
  const SizeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Row(
            children: state.order.product.sizeList!
                .map((s) => Row(
                      children: [
                        FilterChip(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            showCheckmark: false,
                            selectedColor: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: AppColor.primaryColor,
                                width: 2.0,
                              ),
                            ),
                            backgroundColor: state.order.size == s
                                ? AppColor.primaryColor
                                : Colors.white,
                            label: Text(
                              s.size,
                              style: AppStyle.smallTextStyleDark.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: state.order.size == s
                                      ? Colors.white
                                      : AppColor.primaryColor),
                            ),
                            selected: state.order.size == s,
                            onSelected: (bool selected) {
                              if (selected) {
                                context.read<ProductBloc>().add(ChooseSize(s));
                              }
                            }),
                        SizedBox(width: 4,)
                      ],
                    ))
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
