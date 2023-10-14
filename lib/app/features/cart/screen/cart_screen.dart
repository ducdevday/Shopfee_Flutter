import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/cart/widgets/cart_item.dart';
import 'package:shopfee/app/features/cart/widgets/delivery_bottom_sheet.dart';
import 'package:shopfee/app/features/cart/widgets/payment_bottom_sheet.dart';
import 'package:shopfee/app/features/product/bloc/product_bloc.dart';
import 'package:shopfee/app/features/product/widgets/note_opt.dart';
import 'package:shopfee/app/features/product/widgets/size_filter.dart';
import 'package:shopfee/app/features/product/widgets/topping_filter.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/models/order.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartFinished) {
          Navigator.pushNamed(context, "/receipt");
        }
      },
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orders.isEmpty) {
            return Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 1, color: AppColor.primaryColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SvgPicture.asset(
                              "assets/icons/ic_shopping_bag.svg",
                              width: 120,
                              height: 120,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Your cart is empty",
                          style: AppStyle.largeTitleStyleDark,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "You didn't add any product into your cart",
                          style: AppStyle.mediumTextStyleDark,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(AppDimen.screenPadding),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Order now"),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            disabledBackgroundColor: const Color(0xffCACACA),
                            disabledForegroundColor: AppColor.lightColor,
                            textStyle: AppStyle.mediumTextStyleDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Cart"),
                centerTitle: true,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(1),
                  child: Divider(height: 1),
                ),
                actions: [
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: AppColor.primaryColor,
                      ))
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      color: Color(0xffEFEBE9),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppDimen.screenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Product list",
                            style: AppStyle.mediumTitleStyleDark.copyWith(
                                color: AppColor.headingColor,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.cart.orders.length,
                            itemBuilder: (context, index) {
                              return CartItem(
                                  index: index,
                                  callback: () {
                                    buildShowEditOrderBottomSheet(context,
                                        state.cart.orders[index], index);
                                  });
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                height: 15,
                              );
                            },
                          ),
                          // state.cart.orders.map((e) => ).toList(),
                          TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.keyboard_arrow_left_rounded),
                              label: Text(
                                "Add more product",
                                style: AppStyle.normalTextStylePrimary
                                    .copyWith(fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      height: 4,
                      color: Color(0xffEFEBE9),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: AppDimen.screenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Home Delivery",
                                  style: AppStyle.mediumTitleStyleDark
                                      .copyWith(color: AppColor.headingColor)),
                              TextButton(
                                child: Text(
                                  "Change",
                                  style: AppStyle.normalTextStylePrimary,
                                ),
                                onPressed: () {
                                  buildShowDeliveryBottomSheet(context);
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          state.cart.address!.recipientName!,
                                          style: AppStyle.mediumTextStyleDark
                                              .copyWith(
                                                  color: AppColor.headingColor),
                                        ),
                                        Text(
                                          "  |  ",
                                          style: AppStyle.normalTextStyleDark,
                                        ),
                                        Text(
                                          state.cart.address!.phoneNumber!,
                                          style: AppStyle.normalTextStyleDark,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      state.cart.address!.details!,
                                      style: AppStyle.normalTextStyleDark,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                            context, "/saved_address",
                                            arguments: true)
                                        .then((value) => context
                                            .read<CartBloc>()
                                            .add(ChooseAddress(value as String)));
                                  },
                                  child:
                                      Icon(Icons.keyboard_arrow_right_rounded)),
                            ],
                          ),
                          Divider(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Time order",
                                style: AppStyle.mediumTitleStyleDark
                                    .copyWith(color: AppColor.headingColor),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "*We are open from 08:00 AM - 20:00 PM",
                                style: AppStyle.normalTextStyleDark,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "As soon as posible",
                                    style: AppStyle.mediumTextStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_filled_rounded,
                                        color: AppColor.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text("Now - 10 Minute",
                                          style: AppStyle.normalTextStyleDark),
                                    ],
                                  ),
                                ],
                              ),
                              // TimeSetter()
                            ],
                          ),
                          Divider(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment Method",
                                    style: AppStyle.mediumTitleStyleDark
                                        .copyWith(
                                            color: AppColor.headingColor,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/ic_cash.jpg",
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text("Cash",
                                          style: AppStyle.normalTextStyleDark),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    buildShowPaymentBottomSheet(context);
                                  },
                                  child:
                                      Icon(Icons.keyboard_arrow_right_rounded))
                            ],
                          ),
                          Divider(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (value) =>
                                {context.read<CartBloc>().add(AddNote(value))},
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffCCCCCC)),
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffCCCCCC)),
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: "Additional note for shop...",
                            ),
                          ),

                          // Divider(
                          //   height: 20,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text(
                          //           "Voucher",
                          //           style: AppStyle.mediumTitleStyleDark
                          //               .copyWith(
                          //                   color: AppColor.headingColor,
                          //                   fontWeight: FontWeight.w500),
                          //         ),
                          //         SizedBox(
                          //           height: 4,
                          //         ),
                          //         Row(
                          //           children: [
                          //             Icon(
                          //               Icons.discount,
                          //               color: AppColor.primaryColor,
                          //             ),
                          //             SizedBox(
                          //               width: 4,
                          //             ),
                          //             Text("no voucher added",
                          //                 style: AppStyle.normalTextStyleDark),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //     InkWell(
                          //         onTap: () {
                          //           Navigator.pushNamed(context, "/voucher");
                          //         },
                          //         child:
                          //             Icon(Icons.keyboard_arrow_right_rounded))
                          //   ],
                          // ),
                          // Divider(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: 4,
                      color: Color(0xffEFEBE9),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppDimen.screenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment Summary",
                              style: AppStyle.mediumTitleStyleDark
                                  .copyWith(color: AppColor.headingColor)),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price",
                                style: AppStyle.normalTextStyleDark
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                state.cart.totalPriceString,
                                style: AppStyle.normalTextStyleDark
                                    .copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shipping fee",
                                style: AppStyle.normalTextStyleDark
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "0đ",
                                style: AppStyle.normalTextStyleDark
                                    .copyWith(fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Voucher",
                          //       style: AppStyle.normalTextStyleDark
                          //           .copyWith(fontWeight: FontWeight.w400),
                          //     ),
                          //     Text(
                          //       "-30,000đ",
                          //       style: AppStyle.normalTextStyleDark
                          //           .copyWith(fontWeight: FontWeight.w400),
                          //     )
                          //   ],
                          // ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: AppStyle.mediumTitleStyleDark,
                              ),
                              Text(
                                state.cart.totalPriceString,
                                style: AppStyle.mediumTitleStyleDark,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: AppDimen.screenPadding),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<CartBloc>().add(CreateShippingOrder());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40))),
                      child: Text("Order (${state.cart.totalPriceString})"),
                    ),
                  )),
            );
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}

Future<void> buildShowEditOrderBottomSheet(
    BuildContext context, Order order, int index) {
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return EditOrderBottomSheet(order: order, index: index);
      });
}

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
    ;
  }
}

Future<void> buildShowDeliveryBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return DeliveryBottomSheet();
    },
  );
}

Future<void> buildShowPaymentBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    context: context,
    builder: (BuildContext context) {
      return PaymentBottomSheet();
    },
  );
}
