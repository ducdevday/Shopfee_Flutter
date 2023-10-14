import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';

class SugarFilter extends StatelessWidget {
  const SugarFilter({Key? key}) : super(key: key);

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
        //           backgroundColor: state.order.sugar == Sugar.Normal
        //               ? AppColor.primaryColor
        //               : Colors.white,
        //           label: Text(
        //             Sugar.Normal.name,
        //             style: AppStyle.smallTextStyleDark.copyWith(
        //                 fontWeight: FontWeight.bold,
        //                 color: state.order.sugar == Sugar.Normal
        //                     ? Colors.white
        //                     : AppColor.primaryColor),
        //           ),
        //           selected: state.order.sugar == Sugar.Normal,
        //           onSelected: (bool selected) {
        //             if (selected) {
        //               context
        //                   .read<ProductBloc>()
        //                   .add(ChooseSugar(Sugar.Normal));
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
        //           backgroundColor: state.order.sugar == Sugar.Less
        //               ? AppColor.primaryColor
        //               : Colors.white,
        //           label: Text(
        //             Sugar.Less.name,
        //             style: AppStyle.smallTextStyleDark.copyWith(
        //                 fontWeight: FontWeight.bold,
        //                 color: state.order.sugar == Sugar.Less
        //                     ? Colors.white
        //                     : AppColor.primaryColor),
        //           ),
        //           selected: state.order.sugar == Sugar.Less,
        //           onSelected: (bool selected) {
        //             if (selected) {
        //               context
        //                   .read<ProductBloc>()
        //                   .add(ChooseSugar(Sugar.Less));
        //             }
        //           }),
        //     ],
        //   );
        // } else {
          return SizedBox();
        // }
      },
    );
  }
}
