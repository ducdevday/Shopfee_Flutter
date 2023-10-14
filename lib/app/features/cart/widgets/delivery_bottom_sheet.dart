import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/style.dart';

class DeliveryBottomSheet extends StatelessWidget {
  const DeliveryBottomSheet({
    super.key,
  });

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
  }
}