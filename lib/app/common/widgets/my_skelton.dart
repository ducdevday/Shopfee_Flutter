import 'package:flutter/material.dart';

class MySkeleton extends StatelessWidget {
  final double width;
  final double height;
  final double? radious;
  final bool? isCircle;

  const MySkeleton(
      {Key? key,
      required this.width,
      required this.height,
      this.radious = 8,
      this.isCircle = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCircle == false) {
      return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(radious!),
          ),
        ),
      );
    } else {
      return Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey, shape: BoxShape.circle),
      );
    }
  }
}
