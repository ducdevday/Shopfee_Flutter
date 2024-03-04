part of order;

class OrderFilterBottomSheet extends StatefulWidget {
  final int size;
  final num? minPrice;
  final num? maxPrice;
  final num? minStar;
  final ProductSortType? sortType;

  const OrderFilterBottomSheet({
    super.key,
    required this.size,
    required this.minPrice,
    required this.maxPrice,
    required this.minStar,
    required this.sortType,
  });

  @override
  State<OrderFilterBottomSheet> createState() => _OrderFilterBottomSheetState();
}

class _OrderFilterBottomSheetState extends State<OrderFilterBottomSheet> {
  late RangeValues _currentRangeValues;
  late num minStar;
  ProductSortType? sortType;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
        widget.minPrice != null ? widget.minPrice!.toDouble() : 10000,
        widget.maxPrice != null ? widget.maxPrice!.toDouble() : 30000);
    minStar = widget.minStar != null ? widget.minStar!.toDouble() : 0;
    sortType = widget.sortType;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      maxChildSize: 0.8,
      minChildSize: 0.2,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.only(
              left: AppDimen.screenPadding,
              right: AppDimen.screenPadding,
              bottom: AppDimen.screenPadding),
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
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoadSuccess) {
                    return Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Choose Your Filter",
                                style: AppStyle.largeTitleStyleDark,
                              ),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              buildCurrentFilter(state),
                              Text(
                                "Budget",
                                style: AppStyle.mediumTitleStyleDark,
                              ),
                              const SizedBox(
                                height: AppDimen.mediumPadding,
                              ),
                              SliderTheme(
                                data: SliderThemeData(
                                  thumbColor: AppColor.primaryColor,
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 20),
                                  showValueIndicator: ShowValueIndicator.always,
                                ),
                                child: RangeSlider(
                                  values: _currentRangeValues,
                                  max: 200000,
                                  divisions: 20,
                                  inactiveColor: const Color(0xffE5E5E5),
                                  labels: RangeLabels(
                                    "${FormatUtil.formatMoney(_currentRangeValues.start.round())}",
                                    "${FormatUtil.formatMoney(_currentRangeValues.end.round())}",
                                  ),
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      _currentRangeValues = values;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              Text(
                                "Min Rating",
                                style: AppStyle.mediumTitleStyleDark,
                              ),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              RatingBar(
                                  minRating: 0,
                                  maxRating: 5,
                                  initialRating: minStar.toDouble(),
                                  glow: false,
                                  itemPadding: const EdgeInsets.only(
                                      right: AppDimen.smallPadding),
                                  ratingWidget: RatingWidget(
                                      full: Icon(
                                        Icons.star_rounded,
                                        color: AppColor.rating,
                                      ),
                                      half: Icon(
                                        Icons.star_half_rounded,
                                        color: AppColor.rating,
                                      ),
                                      empty: Icon(
                                        Icons.star_rounded,
                                        color: AppColor.secondaryColor,
                                      )),
                                  onRatingUpdate: (value) {
                                    setState(() {
                                      minStar = value;
                                    });
                                  }),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              Text(
                                "Sort By",
                                style: AppStyle.mediumTitleStyleDark,
                              ),
                              const SizedBox(
                                height: AppDimen.spacing,
                              ),
                              ...ProductSortType.values
                                  .mapIndexed((index, e) => Padding(
                                        padding: const EdgeInsets.only(
                                            top: AppDimen.spacing,
                                            bottom: AppDimen.spacing,
                                            right: AppDimen.smallPadding),
                                        child: SortItem<ProductSortType>(
                                            title: ProductSortType.getName(e),
                                            value: e,
                                            groupValue: sortType,
                                            callback: (ProductSortType? value) {
                                              setState(() {
                                                sortType = value;
                                              });
                                            }),
                                      ))
                                  .toList(),
                              const SizedBox(
                                height: AppDimen.smallPadding,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<OrderBloc>().add(
                                            OrderChooseCategory(
                                                page: 1,
                                                size: widget.size,
                                                minPrice:
                                                    _currentRangeValues.start,
                                                maxPrice: _currentRangeValues.end,
                                                minStar: minStar,
                                                sortType: sortType,
                                                category: state.chosenCategory!));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text("Applied Filter")));
                                        NavigationUtil.pop(result: true);
                                      },
                                      child: Text("Apply"),
                                      style: AppStyle.elevatedButtonStylePrimary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppDimen.spacing,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: state.maxPrice != null ||
                                              state.minPrice != null ||
                                              state.minStar != null ||
                                              state.sortType != null
                                          ? () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          dialogContext) =>
                                                      MyConfirmDialog(
                                                        title: "Clear Filter",
                                                        content:
                                                            "Are you sure to clear filter",
                                                        callbackOK: () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        callbackCancel: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      )).then((value) {
                                                if (value != null &&
                                                    value == true) {
                                                  context.read<OrderBloc>().add(
                                                      OrderClearFilter(
                                                          page: 1,
                                                          size: widget.size,
                                                          category: state
                                                              .chosenCategory!));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Cleared Filter")));
                                                  NavigationUtil.pop(
                                                      result: true);
                                                }
                                              });
                                            }
                                          : null,
                                      child: Text("Reset"),
                                      style:
                                          AppStyle.elevatedButtonStyleSecondary,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
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

  Widget buildCurrentFilter(OrderLoadSuccess state) {
    if (state.maxPrice != null ||
        state.minPrice != null ||
        state.minStar != null ||
        state.sortType != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppDimen.smallPadding,
          ),
          Text(
            "Current Filter: ",
            style: AppStyle.mediumTitleStyleDark,
          ),
          const SizedBox(
            height: AppDimen.spacing,
          ),
          if (state.minPrice != null || state.maxPrice != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppDimen.spacing),
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.spacing,
                  horizontal: AppDimen.smallPadding),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Text(
                "Budget: ${FormatUtil.formatMoney(state.minPrice)} - ${FormatUtil.formatMoney(state.maxPrice)}",
                style: AppStyle.normalTextStyleDark,
              ),
            ),
          if (state.minStar != null && state.minStar! != 0)
            Container(
              margin: const EdgeInsets.only(bottom: AppDimen.spacing),
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.spacing,
                  horizontal: AppDimen.smallPadding),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Min Rating: ",
                    style: AppStyle.normalTextStyleDark,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: AppColor.rating,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "${state.minStar}",
                    style: AppStyle.normalTextStyleDark,
                  )
                ],
              ),
            ),
          if (state.sortType != null)
            Container(
              margin: const EdgeInsets.only(bottom: AppDimen.spacing),
              padding: EdgeInsets.symmetric(
                  vertical: AppDimen.spacing,
                  horizontal: AppDimen.smallPadding),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white),
              child: Text(
                "Sort By: ${ProductSortType.getName(state.sortType!)}",
                style: AppStyle.normalTextStyleDark,
              ),
            ),
          const SizedBox(
            height: AppDimen.smallPadding,
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
