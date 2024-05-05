import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/utils/navigation_util.dart';

class LocalImageFullScreen extends StatelessWidget {
  static const String route = "/local_img_full_screen";
  final File file;

  const LocalImageFullScreen({
    required this.file,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Center(
          child: Hero(
            tag: "IMG",
            child: Image.file(file),
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
