part of review;
class ReviewDialog extends StatefulWidget {
  final String orderItemId;

  const ReviewDialog({Key? key, required this.orderItemId}) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  late ValueNotifier<int> ratingNotifier;
  late TextEditingController contentTextController;
  late ValueNotifier<bool> isValidNotifier;

  @override
  void initState() {
    ratingNotifier = ValueNotifier(0);
    contentTextController = TextEditingController();
    isValidNotifier = ValueNotifier(false);
    super.initState();
  }

  @override
  void dispose() {
    ratingNotifier.dispose();
    contentTextController.dispose();
    isValidNotifier.dispose();
    super.dispose();
  }

  String? getErrorText(
      String text,
      FieldType type,
      ) {
    checkValidField();
    if (type == FieldType.note && !ValidateFieldUtil.validateContent(text)) {
      return "Content can't be empty";
    }
    return null;
  }

  void checkValidField() {
    if (ratingNotifier.value == 0 ||
        contentTextController.text.trim().isEmpty) {
      isValidNotifier.value = false;
    }
    isValidNotifier.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                  onTap: () {
                    NavigationUtil.pop();
                  },
                  child: Icon(Icons.close)),
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppPath.imgReview,
                width: AppDimen.smallImageSize,
                height: AppDimen.smallImageSize,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Leave a review",
                style: AppStyle.mediumTitleStyleDark,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Rating",
              style: AppStyle.normalTextStyle
                  .copyWith(color: const Color(0xff3C3C3C)),
            ),
            SizedBox(
              height: 12,
            ),
            RatingBar(
                minRating: 0,
                maxRating: 5,
                glow: false,
                ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star_rounded,
                      color: AppColor.rating,
                      size: 20,
                    ),
                    half: Icon(
                      Icons.star_half_rounded,
                      color: AppColor.rating,
                      size: 20,
                    ),
                    empty: Icon(
                      Icons.star_outline_rounded,
                      color: AppColor.nonactiveColor,
                      size: 20,
                    )),
                onRatingUpdate: (value) =>
                {ratingNotifier.value = value.toInt()}),
            SizedBox(
              height: AppDimen.spacing,
            ),
            TextInputField(
                title: "Content",
                hint: "Type some text",
                validateField: (String value) =>
                    getErrorText(value, FieldType.note),
                controller: contentTextController),
            SizedBox(
              height: AppDimen.smallSpacing,
            ),
            Align(
              child: Text(
                "*Reviews will be visible to the public.",
                style: AppStyle.normalTextStyleDark,
              ),
            ),
            SizedBox(
              height: AppDimen.spacing,
            ),
            ValueListenableBuilder(
              valueListenable: isValidNotifier,
              builder: (BuildContext context, bool isValid, Widget? child) {
                return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: isValid
                            ? () {
                          context.read<ReviewBloc>().add(ReviewCreateNew(
                              orderItemId: widget.orderItemId,
                              star: ratingNotifier.value,
                              content:
                              contentTextController.text.trim()));
                          NavigationUtil.pop();
                        }
                            : null,
                        child: Text("Send Review"),
                        style: AppStyle.elevatedButtonStylePrimary));
              },
            )
          ],
        ),
      ),
    );
  }
}