import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/features/receipt/widgets/cancel_detail.dart';
import 'package:shopfee/app/utils/string_converter_util.dart';

import 'cancel_button.dart';

class DeliveryInformation extends StatelessWidget {
  const DeliveryInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Information",
                      style: AppStyle.mediumTitleStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,AppRouter.trackingRoute,
                              arguments: state.receipt.id);
                        },
                        child: Text("More",
                            style: AppStyle.mediumTextStyleDark
                                .copyWith(color: AppColor.primaryColor)))
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColor.primaryColor,
                          size: 10,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${StringConverterUtil.formattedTime(state.eventLog.time)}",
                          style: AppStyle.smallTextStyleDark,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.eventLog.orderStatus.name}",
                              style: AppStyle.mediumTextStyleDark
                                  .copyWith(color: AppColor.primaryColor),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${state.eventLog.descriptionString}",
                              style: AppStyle.normalTextStyleDark,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 20,
                ),
                CancelButton(),
                CancelDetail(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Delivery Address",
                    style: AppStyle.mediumTitleStyleDark.copyWith(
                        color: AppColor.headingColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state.receipt.address!.recipientName!,
                          style: AppStyle.mediumTextStyleDark
                              .copyWith(color: AppColor.headingColor),
                        ),
                        Text(
                          "  |  ",
                          style: AppStyle.normalTextStyleDark,
                        ),
                        Text(
                          state.receipt.address!.phoneNumber!,
                          style: AppStyle.normalTextStyleDark,
                        ),
                      ],
                    ),
                    Text(
                      state.receipt.address!.details!,
                      style: AppStyle.normalTextStyleDark,
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}


