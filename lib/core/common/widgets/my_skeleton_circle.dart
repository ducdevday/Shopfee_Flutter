import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/core/common/widgets/my_skelton.dart';

class MySkeletonCircle extends MySkeleton {
  const MySkeletonCircle(
      {super.key, required super.width, required super.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(8),
          decoration:
              const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
        ));
  }
}
