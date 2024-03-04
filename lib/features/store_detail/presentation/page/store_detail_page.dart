import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/order/presentation/order.dart';

class StoreDetailPage extends StatelessWidget {
  static const String route = "/store_detail";

  const StoreDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                "https://maytreynhi.com/upload/news/the-coffee-house-co-nhuong-quyen-khong-3668.jpg",
              ),
              Positioned(
                  top: 36,
                  left: AppDimen.screenPadding,
                  child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.disableColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 16,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                      )))
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.smallPadding,
                  vertical: AppDimen.spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shopfee",
                    style: AppStyle.mediumTextStyleDark,
                  ),
                  SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Text(
                    "Vo Van Ngan",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  Text(
                    "Open: 8:00AM - 8:00PM",
                    style: AppStyle.normalTextStyleDark,
                  )
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(
                top: AppDimen.spacing, left: AppDimen.smallPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppPath.icDirect),
                    SizedBox(
                      width: AppDimen.spacing,
                    ),
                    Text(
                      "No 1 Vo Van Ngan Q9 HCM",
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
                Divider(
                  indent: 45,
                  height: 30,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppPath.icPhone),
                    SizedBox(
                      width: AppDimen.spacing,
                    ),
                    Text(
                      "0123456789",
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
                Divider(
                  indent: 45,
                  height: 30,
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppPath.icShare),
                    SizedBox(
                      width: AppDimen.spacing,
                    ),
                    Text(
                      "Share to your friend",
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
                Divider(
                  indent: 45,
                  height: 30,
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(AppDimen.screenPadding),
            child: ElevatedButton(
              onPressed: () {
                NavigationUtil.pop();
                context
                    .read<MyBottomNavBarCubit>()
                    .selectPage(OrderPage.indexPage);
              },
              child: Text("Order Product"),
              style: AppStyle.elevatedButtonStylePrimary,
            ),
          )
        ],
      ),
    );
  }
}
