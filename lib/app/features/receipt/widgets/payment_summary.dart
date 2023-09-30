import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Payment Summary",
                style: AppStyle
                    .mediumTitleStyleDark
                    .copyWith(
                    color: AppColor
                        .headingColor)),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price",
                style: AppStyle
                    .normalTextStyleDark
                    .copyWith(
                    fontWeight:
                    FontWeight.w400),
              ),
              Text(
                "100,000đ",
                style: AppStyle
                    .normalTextStyleDark
                    .copyWith(
                    fontWeight:
                    FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping fee",
                style: AppStyle
                    .normalTextStyleDark
                    .copyWith(
                    fontWeight:
                    FontWeight.w400),
              ),
              Text(
                "20,000đ",
                style: AppStyle
                    .normalTextStyleDark
                    .copyWith(
                    fontWeight:
                    FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Voucher",
                style: AppStyle
                    .normalTextStyleDark
                    .copyWith(
                    fontWeight:
                    FontWeight.w400),
              ),
              Text(
                "-30,000đ",
                style: AppStyle
                    .normalTextStyleDark
                    .copyWith(
                    fontWeight:
                    FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style:
                AppStyle.mediumTitleStyleDark,
              ),
              Text(
                "130,000đ",
                style:
                AppStyle.mediumTitleStyleDark,
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Method",
                style: AppStyle
                    .mediumTitleStyleDark
                    .copyWith(
                    color:
                    AppColor.headingColor,
                    fontWeight:
                    FontWeight.w500),
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
                      style: AppStyle
                          .normalTextStyleDark),
                ],
              ),
            ],
          ),
          Divider(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Status",
                  style: AppStyle
                      .mediumTitleStyleDark
                      .copyWith(
                      color: AppColor
                          .headingColor,
                      fontWeight:
                      FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                SvgPicture.asset(
                    "assets/icons/ic_unpaid.svg"),
              ],
            ),
          ),
          Divider(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "Schedule Delivery",
                  style: AppStyle
                      .mediumTitleStyleDark
                      .copyWith(
                      color: AppColor
                          .headingColor,
                      fontWeight:
                      FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text("05:15 PM",
                    style: AppStyle
                        .normalTextStyleDark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}