part of order;

class OrderSortBottomSheet extends StatefulWidget {
  final ProductSortType? sortType;

  const OrderSortBottomSheet({super.key, this.sortType});

  @override
  State<OrderSortBottomSheet> createState() => _OrderSortBottomSheetState();
}

class _OrderSortBottomSheetState extends State<OrderSortBottomSheet> {
  ProductSortType? sortType;

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
                                  ...ProductSortType.values
                                      .mapIndexed((index, e) => Padding(
                                            padding: const EdgeInsets.only(
                                                top: AppDimen.spacing,
                                                bottom: AppDimen.spacing,
                                                right: AppDimen.smallPadding),
                                            child: SortItem<ProductSortType>(
                                                title: e.getFormattedName(),
                                                value: e,
                                                groupValue: sortType,
                                                callback:
                                                    (ProductSortType? value) {
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
                                    onPressed: () {
                                      context.read<OrderBloc>().add(
                                          OrderApplySort(
                                              initPage: initPage,
                                              initSize: initSize,
                                              sortType: sortType));
                                      AlertUtil.showToast(R.appliedSortType.tr());
                                      NavigationUtil.pop(result: true);
                                    },
                                    style: AppStyle.elevatedButtonStylePrimary,
                                    child: Text(R.apply.tr()),
                                  ),
                                ),
                                const SizedBox(
                                  height: AppDimen.spacing,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: state.sortType != null
                                        ? () {
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext
                                                        dialogContext) =>
                                                    MyConfirmDialog(
                                                      title: R.clearSort.tr(),
                                                      content:
                                                          R.sureToClearSort.tr(),
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
                                                    OrderApplySort(
                                                        initPage: initPage,
                                                        initSize: initSize,
                                                        sortType: null));
                                                AlertUtil.showToast(
                                                    R.clearedSort.tr());
                                                NavigationUtil.pop(
                                                    result: true);
                                              }
                                            });
                                          }
                                        : null,
                                    style:
                                        AppStyle.elevatedButtonStyleSecondary,
                                    child: Text(R.reset.tr()),
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
}
