import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';
import 'package:shopfee/data/models/topping.dart';
import 'package:shopfee/data/models/topping_temp.dart';

class ToppingFilter extends StatefulWidget {

  const ToppingFilter({Key? key}) : super(key: key);

  @override
  State<ToppingFilter> createState() => _ToppingFilterState();
}

class _ToppingFilterState extends State<ToppingFilter> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          final toppings = state.order.product.toppingList!;
          return ListView.separated(
            itemCount: toppings.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    toppings[index].name,
                    style: AppStyle.normalTextStyleDark
                        .copyWith(color: AppColor.headingColor),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                        size: 16,
                      ),
                      Text(toppings[index].priceString,
                          style: AppStyle.mediumTitleStylePrimary
                              .copyWith(color: Color(0xff3A3A3C))),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                        activeColor: AppColor.primaryColor,
                        value: state.order.toppings
                            .contains(toppings[index]),
                        onChanged: (bool? value) {
                          context
                              .read<ProductBloc>()
                              .add(ChooseTopping(toppings[index]));
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => Divider(
              height: 1,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
