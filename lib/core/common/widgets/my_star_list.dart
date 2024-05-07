import 'package:flutter/material.dart';
import 'package:shopfee/core/config/app_color.dart';

class MyStartList extends StatelessWidget {
  final int star;
  final double? size;
  final bool showUnActive;

  const MyStartList(
      {super.key,
      required this.star,
      this.size = 20,
      this.showUnActive = true});

  @override
  Widget build(BuildContext context) {
    Color unRatingColor = showUnActive ? AppColor.unRating : Colors.transparent;
    Color ratingColor = AppColor.rating;

    return showUnActive ?  Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: star == 0 ? unRatingColor : ratingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 2 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 3 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 4 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 5 <= star ? ratingColor : unRatingColor,
          size: size,
        )
      ],
    ) : Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: 5 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 4 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 3 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: 2 <= star ? ratingColor : unRatingColor,
          size: size,
        ),
        Icon(
          Icons.star_rounded,
          color: star == 0 ? unRatingColor : ratingColor,
          size: size,
        ),
      ],
    );
  }
}
