import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/utils/string_converter_util.dart';
import 'package:shopfee/data/models/status_order.dart';

class ReceiptInformation extends StatelessWidget {
  const ReceiptInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ReceiptBloc, ReceiptState>(
        builder: (context, state) {
          if (state is ReceiptLoaded) {
            return Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Builder(builder: (context) {
                  if (state.eventLog.orderStatus != OrderStatus.CANCELED) {
                    return Column(
                      children: [
                        Text(
                          "Thank you!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Builder(builder: (context) {
                          if (state.eventLog.orderStatus !=
                              OrderStatus.SUCCEED) {
                            return Text(
                              "Your order in processing",
                              style: AppStyle.mediumTextStyleDark,
                            );
                          } else {
                            return Text(
                              "Your order was succeed",
                              style: AppStyle.mediumTextStyleDark,
                            );
                          }
                        }),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text(
                          "Oops!",
                          style: AppStyle.largeTitleStylePrimary,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Your order was canceled",
                          style: AppStyle.mediumTextStyleDark,
                        ),
                      ],
                    );
                  }
                }),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ID Transaction",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      state.receipt.id!,
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      StringConverterUtil.formattedDate(
                          state.receipt.createdAt!),
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      StringConverterUtil.formattedTime(
                          state.receipt.createdAt!),
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
