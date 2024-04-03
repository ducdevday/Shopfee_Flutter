import 'package:flutter/material.dart';
import 'package:shopfee/core/common/widgets/my_skeleton.dart';

class MyPlaceHolderRectangle extends MySkeleton {
  final double? radius;

  const MyPlaceHolderRectangle(
      {super.key,
      required super.width,
      required super.height,
      this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(radius!),
        ),
      ),
    );
  }
}
