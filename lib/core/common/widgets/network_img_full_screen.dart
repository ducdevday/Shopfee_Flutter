import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/utils/navigation_util.dart';

class NetworkImageFullScreen extends StatelessWidget {
  static const String route = "/network_img_full_screen";
  final String url;

  const NetworkImageFullScreen({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: Hero(
            tag: "IMG",
            child: CachedNetworkImage(
              imageUrl: url,
              errorWidget: (_, __, ___) => Container(
                  color: AppColor.unLikedColor,
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                    size: AppDimen.largeSize,
                  )),
            ),
          ),
        ),
        Positioned(
          top: AppDimen.headerMargin,
          left: AppDimen.screenPadding,
          child: GestureDetector(
            onTap: () {
              NavigationUtil.pop();
            },
            child: Hero(
              tag: "close_button",
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
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}
