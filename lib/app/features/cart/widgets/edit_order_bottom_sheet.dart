import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';
import 'package:shopfee/app/features/product/widgets/note_opt.dart';
import 'package:shopfee/app/features/product/widgets/size_filter.dart';
import 'package:shopfee/app/features/product/widgets/topping_filter.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

class EditOrderBottomSheet extends StatelessWidget {
  final Order order;
  final int index;

  EditOrderBottomSheet({required this.order, Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductBloc(productRepository: context.read<ProductRepository>())
        ..add(LoadUpdatingProduct(order)),
      child: Wrap(
        // child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.delete_rounded)),
              Text(
                order.product.name!,
                style: AppStyle.mediumTitleStyleDark,
              ),
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close_rounded))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 4,
            color: Color(0xffEFEBE9),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Customize",
                        style: AppStyle.mediumTextStyleDark.copyWith(
                            color: AppColor.headingColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Size",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(color: AppColor.headingColor)),
                      const SizeFilter()
                    ],
                  ),
                ],
              )),
          Container(
            height: 4,
            color: Color(0xffEFEBE9),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Topping",
                      style: AppStyle.mediumTextStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.bold)),
                ),
                ToppingFilter()
              ],
            ),
          ),
          Container(
            height: 4,
            color: Color(0xffEFEBE9),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Note",
                      style: AppStyle.mediumTextStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 16,
                ),
                const NoteOpt(),
              ],
            ),
          ),
          Container(
            height: 12,
            color: Color(0xffEFEBE9),
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(DecreaseQuantityAndDelete());
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(4),
                              backgroundColor:
                              Color(0xffBCAAA4), // <-- Button color
                            ),
                            child: Icon(
                              Icons.remove,
                              color: AppColor.primaryColor,
                              size: 18,
                            ),
                          ),
                          BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              if (state is ProductLoaded) {
                                return Text(state.order.quantity.toString(),
                                    style: AppStyle.mediumTitleStyleDark);
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductBloc>()
                                  .add(IncreaseQuantity());
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(4),
                              backgroundColor:
                              Color(0xffBCAAA4), // <-- Button color
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColor.primaryColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(UpdateItemInCart(
                                  updatedOrder: state.order, index: index));
                              Navigator.pop(context);
                            },
                            style: AppStyle.elevatedButtonStylePrimary,
                            child: Text(state.order.quantity == 0
                                ? "Remove this product"
                                : "Update ${state.order.totalString}")),
                      )
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
        // ),
      ),
    );
  }
}
