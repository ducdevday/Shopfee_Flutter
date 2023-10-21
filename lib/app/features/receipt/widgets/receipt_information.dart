import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/utils/my_converter.dart';
import 'package:shopfee/data/models/receipt.dart';
import 'package:shopfee/data/models/receipt.dart';

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
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Thank you!",
                  style: AppStyle.largeTitleStylePrimary,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Your order was successful",
                  style: AppStyle.mediumTextStyleDark,
                ),
                SizedBox(
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
                SizedBox(
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
                      MyConverter.formattedDate(state.receipt.createdAt!) ,
                      style: AppStyle.normalTextStyleDark,
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
                      "Time",
                      style: AppStyle.mediumTitleStyleDark,
                    ),
                    Text(
                      MyConverter.formattedTime(state.receipt.createdAt!),
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
