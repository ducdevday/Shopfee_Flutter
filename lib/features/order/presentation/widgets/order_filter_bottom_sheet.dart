part of order;

class OrderFilterBottomSheet extends StatefulWidget {
  final num? minPrice;
  final num? maxPrice;
  final num? minStar;
  final String? branchId;

  const OrderFilterBottomSheet({
    super.key,
    required this.minPrice,
    required this.maxPrice,
    required this.minStar,
    required this.branchId,
  });

  @override
  State<OrderFilterBottomSheet> createState() => _OrderFilterBottomSheetState();
}

class _OrderFilterBottomSheetState extends State<OrderFilterBottomSheet> {
  late RangeValues _currentRangeValues;
  late num minStar;
  late StoreUseCase storeUseCase;
  late String storeId;

  late TextEditingController storeTextController;
  late ValueNotifier<bool> useBudget;
  late ValueNotifier<bool> useMinStar;
  late ValueNotifier<bool> useStore;

  final ValueNotifier<List<StoreInformationEntity>> stores = ValueNotifier([]);

  int initPage = 1;
  int initSize = 8;

  @override
  void initState() {
    super.initState();
    useBudget = ValueNotifier(widget.minPrice != null ? true : false);
    useMinStar = ValueNotifier(widget.minStar != null ? true : false);
    useStore = ValueNotifier(widget.branchId != null ? true : false);
    _currentRangeValues = RangeValues(
        widget.minPrice != null ? widget.minPrice!.toDouble() : 10000,
        widget.maxPrice != null ? widget.maxPrice!.toDouble() : 30000);
    minStar = widget.minStar != null ? widget.minStar!.toDouble() : 0;
    storeId = widget.branchId ?? "";
    storeTextController = TextEditingController();
    storeUseCase = ServiceLocator.sl<StoreUseCase>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (useStore.value == true) {
        getAllStore();
      }
    });
  }

  void getAllStore() async {
    if (await PermissionUtil.requestLocationPermission() == false ||
        stores.value.isNotEmpty) {
      return;
    }
    Position currentPosition = await GlobalData.ins.getCurrentPosition();
    stores.value = await storeUseCase.getAllStores(StoreAllParamsEntity(
          key: "",
          all: true,
          lat: currentPosition.latitude,
          lng: currentPosition.longitude,
          page: 1,
          size: 200,
        )) ??
        [];
    storeTextController.text =
        stores.value.firstWhereOrNull((element) => element.id == storeId)?.name ?? "";
  }

  @override
  void dispose() {
    useBudget.dispose();
    useMinStar.dispose();
    useStore.dispose();
    storeTextController.dispose();
    super.dispose();
  }

  String? getCheckedStore() {
    if (useStore.value == true) {
      return storeId;
    }
    return null;
  }

  num? getCheckedMinBudget() {
    if (useBudget.value == true) {
      return _currentRangeValues.start;
    }
    return null;
  }

  num? getCheckedMaxBudget() {
    if (useBudget.value == true) {
      return _currentRangeValues.end;
    }
    return null;
  }

  num? getCheckedMinStar() {
    if (useMinStar.value == true) {
      return minStar;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.75,
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
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoadSuccess) {
                    return Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose Filter",
                                    style: AppStyle.largeTitleStyleDark,
                                  ),
                                  const SizedBox(
                                    height: AppDimen.smallPadding,
                                  ),
                                  buildCurrentFilter(state),
                                  buildFilterBudget(),
                                  const SizedBox(
                                    height: AppDimen.smallPadding,
                                  ),
                                  buildFilterStar(),
                                  const SizedBox(
                                    height: AppDimen.smallPadding,
                                  ),
                                  buildFilterStore(),
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
                                    onPressed: () {
                                      context.read<OrderBloc>().add(
                                          OrderApplyFilter(
                                              initPage: initPage,
                                              initSize: initSize,
                                              branchId: getCheckedStore(),
                                              minPrice: getCheckedMinBudget(),
                                              maxPrice: getCheckedMaxBudget(),
                                              minStar: getCheckedMinStar()));
                                      AlertUtil.showToast("Applied Filter");
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
                                            state.branchId != null
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
                                                    OrderApplyFilter(
                                                        initPage: initPage,
                                                        initSize: initSize,
                                                        branchId: null,
                                                        minPrice: null,
                                                        maxPrice: null,
                                                        minStar: null));
                                                AlertUtil.showToast(
                                                    "Cleared Filter");
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

  ValueListenableBuilder<bool> buildFilterStar() {
    return ValueListenableBuilder<bool>(
      valueListenable: useMinStar,
      builder: (BuildContext context, bool isUseMinStar, Widget? child) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Min Rating",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                ),
                MyCheckbox(
                    value: useMinStar.value,
                    onChanged: (isCheck) {
                      if (isCheck != null) {
                        useMinStar.value = isCheck;
                      }
                    })
              ],
            ),
            const SizedBox(
              height: AppDimen.smallPadding,
            ),
            if (isUseMinStar)
              RatingBar(
                  minRating: 0,
                  maxRating: 5,
                  initialRating: minStar.toDouble(),
                  glow: false,
                  itemPadding:
                      const EdgeInsets.only(right: AppDimen.smallPadding),
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
          ],
        );
      },
    );
  }

  ValueListenableBuilder<bool> buildFilterBudget() {
    return ValueListenableBuilder(
      valueListenable: useBudget,
      builder: (BuildContext context, bool isUseBudget, Widget? child) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Budget",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                ),
                MyCheckbox(
                    value: useBudget.value,
                    onChanged: (isCheck) {
                      if (isCheck != null) {
                        useBudget.value = isCheck;
                      }
                    })
              ],
            ),
            if (isUseBudget)
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "${FormatUtil.formatMoney(_currentRangeValues.start.round())}",
                    textAlign: TextAlign.center,
                    style: AppStyle.mediumTitleStyleDark,
                  )),
                  Expanded(
                      child: Text(
                    "~",
                    textAlign: TextAlign.center,
                    style: AppStyle.normalTextStyleDark.copyWith(fontSize: 40),
                  )),
                  Expanded(
                      child: Text(
                    "${FormatUtil.formatMoney(_currentRangeValues.end.round())}",
                    textAlign: TextAlign.center,
                    style: AppStyle.mediumTitleStyleDark,
                  )),
                ],
              ),
            if (isUseBudget)
              RangeSlider(
                values: _currentRangeValues,
                max: 500000,
                divisions: 50,
                inactiveColor: const Color(0xffE5E5E5),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
          ],
        );
      },
    );
  }

  ValueListenableBuilder<bool> buildFilterStore() {
    return ValueListenableBuilder(
      valueListenable: useStore,
      builder: (BuildContext context, bool isUseStore, Widget? child) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Store",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                ),
                MyCheckbox(
                    value: useStore.value,
                    onChanged: (isCheck) {
                      if (isCheck != null) {
                        useStore.value = isCheck;
                        if (useStore.value == true) {
                          getAllStore();
                        }
                      }
                    })
              ],
            ),
            if (isUseStore)
              SizedBox(
                height: AppDimen.spacing,
              ),
            if (isUseStore)
              ValueListenableBuilder(
                valueListenable: stores,
                builder: (BuildContext context,
                    List<StoreInformationEntity> storeValues, Widget? child) {
                  return DropdownMenu<StoreInformationEntity>(
                    menuHeight: 200,
                    width: MediaQuery.of(context).size.width -
                        AppDimen.screenPadding * 2,
                    onSelected: (store) => {
                      if (store != null)
                        {
                          storeId = store.id!,
                          storeTextController.text = store.name ?? ""
                        }
                    },
                    dropdownMenuEntries: [
                      ...storeValues.mapIndexed((index, e) => DropdownMenuEntry(
                          value: storeValues[index],
                          label: storeValues[index].name ?? ""))
                    ],
                    controller: storeTextController,
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      focusedErrorBorder: AppStyle.outlineInputBorderDefault,
                      errorBorder: AppStyle.outlineInputBorderDefault,
                      enabledBorder: AppStyle.outlineInputBorderDefault,
                      focusedBorder: AppStyle.outlineInputBorderPrimary,
                      disabledBorder: AppStyle.outlineInputBorderDefault,
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Widget buildCurrentFilter(OrderLoadSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: AppDimen.smallPadding,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Current Filter: ",
                style: AppStyle.mediumTitleStyleDark,
              ),
            ),
            if (state.maxPrice == null &&
                state.minPrice == null &&
                state.minStar == null)
              Text(
                "No Options",
                style: AppStyle.mediumTitleStyleDark,
              ),
          ],
        ),
        const SizedBox(
          height: AppDimen.spacing,
        ),
        if (state.minPrice != null || state.maxPrice != null)
          Container(
            margin: const EdgeInsets.only(bottom: AppDimen.spacing),
            padding: EdgeInsets.symmetric(
                vertical: AppDimen.spacing, horizontal: AppDimen.smallPadding),
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
                vertical: AppDimen.spacing, horizontal: AppDimen.smallPadding),
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
        if (state.branchId != null)
          ValueListenableBuilder(
            valueListenable: stores,
            builder: (BuildContext context,
                List<StoreInformationEntity> storesValue, Widget? child) {
              return Container(
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
                      "Store: ",
                      style: AppStyle.normalTextStyleDark,
                    ),
                    Text(
                      "${storesValue.firstWhereOrNull((element) => element.id == storeId)?.name ?? ""}",
                      style: AppStyle.normalTextStyleDark,
                    )
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
