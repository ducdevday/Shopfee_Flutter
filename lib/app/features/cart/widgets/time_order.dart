import 'package:flutter/material.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';

class TimeOrder extends StatelessWidget {
  const TimeOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Time order",
          style: AppStyle.mediumTitleStyleDark
              .copyWith(color: AppColor.headingColor),
        ),
        const SizedBox(
          height: 4,
        ),
        Builder(builder: (_) {
          // if (!(DateTime.now().hour >= 8 && DateTime.now().hour < 20)) {
          //   return Text(
          //     "*We are open from 08:00 AM - 20:00 PM",
          //     style: AppStyle.normalTextStyleDark.copyWith(color: AppColor.error),
          //   );
          // } else {
            return Text(
              "*We are open from 08:00 AM - 20:00 PM",
              style: AppStyle.normalTextStyleDark,
            );
          // }
        }),
        const SizedBox(
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
                  style: AppStyle.mediumTextStyleDark.copyWith(
                      color: AppColor.headingColor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled_rounded,
                      color: AppColor.primaryColor,
                    ),
                    const SizedBox(
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
      ],
    );
  }
}
