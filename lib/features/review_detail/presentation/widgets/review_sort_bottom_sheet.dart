part of review_detail;

class ReviewSortBottomSheet extends StatefulWidget {
  final ReviewSortType? sortType;

  const ReviewSortBottomSheet({super.key, this.sortType});

  @override
  State<ReviewSortBottomSheet> createState() => _ReviewSortBottomSheetState();
}

class _ReviewSortBottomSheetState extends State<ReviewSortBottomSheet> {
  ReviewSortType? sortType;

  int initPage = 1;
  int initSize = 8;

  @override
  void initState() {
    super.initState();
    sortType = widget.sortType;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.6,
      minChildSize: 0.2,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(
            left: AppDimen.screenPadding,
            right: AppDimen.screenPadding,
          ),
          decoration: BoxDecoration(
            color: AppColor.bottomColorBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimen.mediumPadding),
              topRight: Radius.circular(AppDimen.mediumPadding),
            ),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: AppDimen.screenPadding),
                child: Container(
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimen.mediumPadding,
              ),
              BlocBuilder<ReviewDetailBloc, ReviewDetailState>(
                builder: (context, state) {
                  if (state is ReviewDetailLoadSuccess) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    R.chooseSortType.tr(),
                                    style: AppStyle.largeTitleStyleDark,
                                  ),
                                  const SizedBox(
                                    height: AppDimen.smallPadding,
                                  ),
                                  Text(
                                    R.sortBy.tr(),
                                    style: AppStyle.mediumTitleStyleDark,
                                  ),
                                  const SizedBox(
                                    height: AppDimen.spacing,
                                  ),
                                  ...ReviewSortType.values
                                      .mapIndexed((index, e) => Padding(
                                            padding: const EdgeInsets.only(
                                                top: AppDimen.spacing,
                                                bottom: AppDimen.spacing,
                                                right: AppDimen.smallPadding),
                                            child: SortItem<ReviewSortType>(
                                                title: e.getFormattedName(),
                                                value: e,
                                                groupValue: sortType,
                                                callback:
                                                    (ReviewSortType? value) {
                                                  setState(() {
                                                    sortType = value;
                                                  });
                                                }),
                                          ))
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: AppDimen.smallPadding),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: sortType != null ?() {
                                      context.read<ReviewDetailBloc>().add(
                                          ReviewDetailApplySort(
                                              initPage: initPage,
                                              initSize: initSize,
                                              sortType: sortType));
                                      AlertUtil.showToast(R.appliedSortType.tr());
                                      NavigationUtil.pop(result: true);
                                    }: null,
                                    style: AppStyle.elevatedButtonStylePrimary,
                                    child: Text(R.apply.tr()),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
