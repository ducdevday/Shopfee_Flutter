import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';

class MyStartList extends StatelessWidget {
  final int star;
  final double? size;

  const MyStartList({
    super.key,
    required this.star,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: star == 0 ? AppColor.unRating : AppColor.rating,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 2 <= star ? AppColor.rating : AppColor.unRating,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 3 <= star ? AppColor.rating : AppColor.unRating,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 4 <= star ? AppColor.rating : AppColor.unRating,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 5 <= star ? AppColor.rating : AppColor.unRating,
          size: size,
        )
      ],
    );
  }
}
