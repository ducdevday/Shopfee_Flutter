import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';
import 'package:shopfee/data/models/order.dart';

class VariantFilter extends StatelessWidget {
  const VariantFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        // if (state is ProductLoaded) {
        //   return Row(
        //     children: [
        //       FilterChip(
        //           padding: EdgeInsets.symmetric(horizontal: 4),
        //           showCheckmark: false,
        //           selectedColor: AppColor.primaryColor,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10.0),
        //             side: BorderSide(
        //               color: AppColor.primaryColor,
        //               width: 2.0,
        //             ),
        //           ),
        //           backgroundColor: state.order.variant == Variant.Ice
        //               ? AppColor.primaryColor
        //               : Colors.white,
        //           label: Text(
        //             Variant.Ice.name,
        //             style: AppStyle.smallTextStyleDark.copyWith(
        //                 fontWeight: FontWeight.bold,
        //                 color: state.order.variant == Variant.Ice
        //                     ? Colors.white
        //                     : AppColor.primaryColor),
        //           ),
        //           selected: state.order.variant == Variant.Ice,
        //           onSelected: (bool selected) {
        //             if (selected) {
        //               context
        //                   .read<ProductBloc>()
        //                   .add(ChooseVariant(Variant.Ice));
        //             }
        //           }),
        //       SizedBox(width: 8),
        //       FilterChip(
        //           padding: EdgeInsets.symmetric(horizontal: 4),
        //           showCheckmark: false,
        //           selectedColor: AppColor.primaryColor,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10.0),
        //             side: BorderSide(
        //               color: AppColor.primaryColor,
        //               width: 2.0,
        //             ),
        //           ),
        //           backgroundColor: state.order.variant == Variant.Hot
        //               ? AppColor.primaryColor
        //               : Colors.white,
        //           label: Text(
        //             Variant.Hot.name,
        //             style: AppStyle.smallTextStyleDark.copyWith(
        //                 fontWeight: FontWeight.bold,
        //                 color: state.order.variant == Variant.Hot
        //                     ? Colors.white
        //                     : AppColor.primaryColor),
        //           ),
        //           selected: state.order.variant == Variant.Hot,
        //           onSelected: (bool selected) {
        //             if (selected) {
        //               context
        //                   .read<ProductBloc>()
        //                   .add(ChooseVariant(Variant.Hot));
        //             }
        //           })
        //     ],
        //   );
        // } else {
          return SizedBox();
        // }
      },
    );
  }
}
