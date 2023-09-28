import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';
import 'package:shopfee/data/models/order.dart';

class SizeFilter extends StatelessWidget {
  const SizeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Row(
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
                  backgroundColor: state.order.size == Size.Small
                      ? AppColor.primaryColor
                      : Colors.white,
                  label: Text(
                    Size.Small.name,
                    style: AppStyle.smallTextStyleDark.copyWith(
                        fontWeight: FontWeight.bold,
                        color: state.order.size == Size.Small
                            ? Colors.white
                            : AppColor.primaryColor),
                  ),
                  selected: state.order.size == Size.Small,
                  onSelected: (bool selected) {
                    if (selected) {
                      context
                          .read<ProductBloc>()
                          .add(ChooseSize(Size.Small));
                    }
                  }),
              SizedBox(width: 8),
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
                  backgroundColor: state.order.size == Size.Medium
                      ? AppColor.primaryColor
                      : Colors.white,
                  label: Text(
                    Size.Medium.name,
                    style: AppStyle.smallTextStyleDark.copyWith(
                        fontWeight: FontWeight.bold,
                        color: state.order.size == Size.Medium
                            ? Colors.white
                            : AppColor.primaryColor),
                  ),
                  selected: state.order.size == Size.Medium,
                  onSelected: (bool selected) {
                    if (selected) {
                      context
                          .read<ProductBloc>()
                          .add(ChooseSize(Size.Medium));
                    }
                  }),
              SizedBox(width: 8),
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
                  backgroundColor: state.order.size == Size.Large
                      ? AppColor.primaryColor
                      : Colors.white,
                  label: Text(
                    Size.Large.name,
                    style: AppStyle.smallTextStyleDark.copyWith(
                        fontWeight: FontWeight.bold,
                        color: state.order.size == Size.Large
                            ? Colors.white
                            : AppColor.primaryColor),
                  ),
                  selected: state.order.size == Size.Large,
                  onSelected: (bool selected) {
                    if (selected) {
                      context
                          .read<ProductBloc>()
                          .add(ChooseSize(Size.Large));
                    }
                  }),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
