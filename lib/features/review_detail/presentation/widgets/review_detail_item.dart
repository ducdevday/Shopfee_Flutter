part of review_detail;

class ReviewDetailItem extends StatefulWidget {
  final ReviewDetailEntity reviewDetail;

  const ReviewDetailItem({
    super.key,
    required this.reviewDetail,
  });

  @override
  State<ReviewDetailItem> createState() => _ReviewDetailItemState();
}

class _ReviewDetailItemState extends State<ReviewDetailItem> {
  late ValueNotifier<ReviewInteractionType?> currentInteractionNotifier;

  int currentLike = 0;
  int currentDislike = 0;

  @override
  void initState() {
    super.initState();
    currentInteractionNotifier = ValueNotifier(widget.reviewDetail.interaction);
    currentLike = widget.reviewDetail.likeQuantity;
    currentDislike = widget.reviewDetail.dislikeQuantity;
  }

  @override
  void dispose() {
    currentInteractionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppDimen.smallRadius)),
              child: CachedNetworkImage(
                imageUrl: widget.reviewDetail.avatarUrl ?? AppPath.imgDefaultAvatar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                placeholder: (context, url) => const MyPlaceHolderRectangle(
                  width: AppDimen.smallImageSize,
                  height: AppDimen.smallImageSize,
                ),
                errorWidget: (_, __, ___) => Image.asset(
                  AppPath.imgImageError,
                  width: AppDimen.smallImageSize,
                  height: AppDimen.smallImageSize,
                ),
              ),
            ),
            const SizedBox(
              width: AppDimen.spacing,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.reviewDetail.reviewerName}",
                    style: AppStyle.mediumTextStyleDark,
                  ),
                  const SizedBox(
                    height: AppDimen.smallSpacing,
                  ),
                  Text(
                    "${timeago.format(widget.reviewDetail.createdAt ?? DateTime.now())}",
                    style: AppStyle.normalTextStyleDark
                        .copyWith(color: AppColor.nonactiveColor),
                  ),
                ],
              ),
            ),
            MyStartList(
              star: widget.reviewDetail.star,
              size: AppDimen.smallSize,
            )
          ],
        ),
        const SizedBox(
          height: AppDimen.spacing,
        ),
        ReadMoreText("${widget.reviewDetail.content}",
            style: AppStyle.normalTextStyleDark,
            trimLines: 2,
            trimMode: TrimMode.Line,
            colorClickableText: AppColor.primaryColor),
        const SizedBox(
          height: AppDimen.spacing,
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadSuccess) {
              return Column(
                children: [
                  DottedLine(
                    direction: Axis.horizontal,
                    dashLength: 8.0,
                    dashColor: AppColor.dividerColor,
                  ),
                  const SizedBox(
                    height: AppDimen.spacing,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ValueListenableBuilder(
                          valueListenable: currentInteractionNotifier,
                          builder: (BuildContext context,
                              ReviewInteractionType? currentInteraction,
                              Widget? child) {
                            return LikeButton(
                              size: AppDimen.smallSize,
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              isLiked: currentInteraction ==
                                  ReviewInteractionType.LIKE,
                              likeBuilder: (bool isLiked) {
                                return SvgPicture.asset(
                                  AppPath.icLike,
                                  color: isLiked
                                      ? AppColor.likeColor
                                      : AppColor.nonactiveColor,
                                  width: AppDimen.smallSize,
                                  height: AppDimen.smallSize,
                                );
                              },
                              likeCount: currentLike,
                              countBuilder:
                                  (int? count, bool isLiked, String text) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      width: AppDimen.spacing,
                                    ),
                                    Text(
                                      text,
                                      style: AppStyle.normalTextStyleDark
                                          .copyWith(
                                              color: isLiked
                                                  ? AppColor.likeColor
                                                  : AppColor.nonactiveColor),
                                    ),
                                  ],
                                );
                              },
                              onTap: (bool isLiked) async {
                                context.read<ReviewDetailBloc>().add(
                                    ReviewDetailLikeBtnPressed(
                                        productReviewId:
                                            widget.reviewDetail.id));
                                if (currentInteractionNotifier.value ==
                                    ReviewInteractionType.DISLIKE) {
                                  currentDislike = currentDislike - 1;
                                }
                                if (currentInteractionNotifier.value ==
                                    ReviewInteractionType.LIKE) {
                                  currentInteractionNotifier.value = null;
                                  currentLike = currentLike - 1;
                                } else {
                                  currentInteractionNotifier.value =
                                      ReviewInteractionType.LIKE;
                                  currentLike = currentLike + 1;
                                }
                                return !isLiked;
                              },
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ValueListenableBuilder(
                          valueListenable: currentInteractionNotifier,
                          builder: (BuildContext context,
                              ReviewInteractionType? currentInteraction,
                              Widget? child) {
                            return LikeButton(
                              size: AppDimen.smallSize,
                              circleColor: CircleColor(
                                start: Colors.redAccent[100]!,
                                end: Colors.redAccent[400]!,
                              ),
                              bubblesColor: BubblesColor(
                                dotPrimaryColor: Colors.red[300]!,
                                dotSecondaryColor: Colors.red[200]!,
                              ),
                              isLiked: currentInteraction ==
                                  ReviewInteractionType.DISLIKE,
                              likeBuilder: (bool isLiked) {
                                return SvgPicture.asset(
                                  AppPath.icDisLike,
                                  color: isLiked
                                      ? AppColor.disLikeColor
                                      : AppColor.nonactiveColor,
                                  width: AppDimen.smallSize,
                                  height: AppDimen.smallSize,
                                );
                              },
                              likeCount: currentDislike,
                              countBuilder:
                                  (int? count, bool isLiked, String text) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      width: AppDimen.spacing,
                                    ),
                                    Text(
                                      text,
                                      style: AppStyle.normalTextStyleDark
                                          .copyWith(
                                              color: isLiked
                                                  ? AppColor.disLikeColor
                                                  : AppColor.nonactiveColor),
                                    ),
                                  ],
                                );
                              },
                              onTap: (bool isLiked) async {
                                context.read<ReviewDetailBloc>().add(
                                    ReviewDetailDislikeBtnPressed(
                                        productReviewId:
                                            widget.reviewDetail.id));
                                if (currentInteractionNotifier.value ==
                                    ReviewInteractionType.LIKE) {
                                  currentLike = currentLike - 1;
                                }
                                if (currentInteractionNotifier.value ==
                                    ReviewInteractionType.DISLIKE) {
                                  currentInteractionNotifier.value = null;
                                  currentDislike = currentDislike - 1;
                                } else {
                                  currentInteractionNotifier.value =
                                      ReviewInteractionType.DISLIKE;
                                  currentDislike = currentDislike + 1;
                                }
                                return !isLiked;
                              },
                            );
                          },
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      )
                    ],
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        )
      ],
    ));
  }
}
