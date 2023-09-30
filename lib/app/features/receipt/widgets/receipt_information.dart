import 'package:flutter/material.dart';
import 'package:shopfee/app/config/style.dart';

class ReceiptInformation extends StatelessWidget {
  const ReceiptInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "Thank you!",
            style:
            AppStyle.largeTitleStylePrimary,
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
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID Transaction",
                style:
                AppStyle.mediumTitleStyleDark,
              ),
              Text(
                "D123456789ABC",
                style:
                AppStyle.normalTextStyleDark,
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
                "Date",
                style:
                AppStyle.mediumTitleStyleDark,
              ),
              Text(
                "July 2023",
                style:
                AppStyle.normalTextStyleDark,
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
                "Time",
                style:
                AppStyle.mediumTitleStyleDark,
              ),
              Text(
                "04:13 PM",
                style:
                AppStyle.normalTextStyleDark,
              )
            ],
          ),
        ],
      ),
    );
  }
}
