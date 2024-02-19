import 'package:flutter/material.dart';
import 'package:shopfee/core/common/widgets/my_skelton.dart';

class MySkeletonCircle extends MySkeleton {
  const MySkeletonCircle(
      {super.key, required super.width, required super.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration:
          const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
    );
  }
}
