import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/cart/widgets/cart_item.dart';
import 'package:shopfee/app/features/cart/widgets/time_setter.dart';
import 'package:shopfee/data/models/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Cart"),
              centerTitle: true,
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
                            return CartItem(index: index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 10,
                            );
                          },
                        ),
                        // state.cart.orders.map((e) => ).toList(),
                        TextButton.icon(
                            onPressed: () {},
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("KTX khu B Đại học Quốc gia",
                                style: AppStyle.normalTextStyleDark),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              padding: EdgeInsets.only(right: 5),
                              constraints: BoxConstraints(),
                              icon: Icon(
                                Icons.map_outlined,
                                color: AppColor.primaryColor,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/geolocation");
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        TextField(
                          onChanged: (value) => {},
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
                            hintText: "Add introduction for delivery...",
                          ),
                        ),
                        Divider(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "When do you want order?",
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
                                  style: AppStyle.mediumTitleStyleDark.copyWith(
                                      color: AppColor.headingColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time_filled_rounded, color: AppColor.primaryColor,),
                                    SizedBox(width: 4,),
                                    Text("Now - 10 Minute",
                                        style: AppStyle.normalTextStyleDark),
                                  ],
                                ),
                              ],
                            ),
                            TimeSetter()
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
                                  style: AppStyle.mediumTitleStyleDark.copyWith(
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
                                    SizedBox(width: 4,),
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
                                child: Icon(Icons.keyboard_arrow_right_rounded))
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
                                  "Voucher",
                                  style: AppStyle.mediumTitleStyleDark.copyWith(
                                      color: AppColor.headingColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.discount,color: AppColor.primaryColor,),
                                    SizedBox(width: 4,),
                                    Text("no voucher added",
                                        style: AppStyle.normalTextStyleDark),
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/voucher");
                                },
                                child: Icon(Icons.keyboard_arrow_right_rounded))
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
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
                              "20,000đ",
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
                              "Voucher",
                              style: AppStyle.normalTextStyleDark
                                  .copyWith(fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "-30,000đ",
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
                              "Total",
                              style: AppStyle.mediumTitleStyleDark,
                            ),
                            Text(
                              "130,000đ",
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
                    child: Text("Order (130,000đ)"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/receipt");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                  ),
                )),
          );
        } else {
          return SizedBox();
        }
      },
    );
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
      return Wrap(
        // child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.close_rounded)),
              ),
              Text(
                "Choose Order Method",
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
            padding: EdgeInsets.all(10),
            color: AppColor.primaryColor.withAlpha(30),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_delivery.svg",
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Home Delivery",
                        style: AppStyle.mediumTitleStyleDark
                            .copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("KTX khu B Đại học Quốc gia",
                          style: AppStyle.normalTextStyleDark),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Change",
                      style: AppStyle.normalTextStyle,
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/ic_take_away.svg",
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Take Away",
                        style: AppStyle.mediumTitleStyleDark
                            .copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Shopfee, No 1 Võ Văn Ngân",
                          style: AppStyle.normalTextStyleDark),
                    ],
                  ),
                ),
                Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Change",
                        style: AppStyle.normalTextStyle,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)))),
                )
              ],
            ),
          )
        ],
        // ),
      );
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

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({
    super.key,
  });

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  TypePayment? typePayment = TypePayment.CASH;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: false,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child:
                  IconButton(onPressed: () {}, icon: Icon(Icons.close_rounded)),
            ),
            Text(
              "Choose Payment Method",
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/ic_cash.jpg",
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(child: Text("Cash")),
              Radio(
                  activeColor: AppColor.primaryColor,
                  value: TypePayment.CASH,
                  groupValue: typePayment,
                  onChanged: (TypePayment? value) {
                    setState(() {
                      typePayment = value;
                    });
                  })
            ],
          ),
        ),
        Divider(
          height: 10,
          indent: 10,
          endIndent: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Image.asset(
                "assets/icons/ic_vnpay.png",
                width: 24,
                height: 24,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(child: Text("VNPAY")),
              Radio(
                  activeColor: AppColor.primaryColor,
                  value: TypePayment.VNPAY,
                  groupValue: typePayment,
                  onChanged: (TypePayment? value) {
                    setState(() {
                      typePayment = value;
                    });
                  })
            ],
          ),
        ),
      ],
      // ),
    );
  }
}
