import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/core/common/widgets/my_skelton.dart';

class MySkeletonRectangle extends MySkeleton {
  final double? radius;

  const MySkeletonRectangle(
      {super.key,
      required super.width,
      required super.height,
      this.radius = 8});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(radius!),
            ),
          ),
        ));
  }
}
