part of cart;

class EditOrderBottomSheet extends StatefulWidget {
  final OrderEntity order;
  final int index;

  EditOrderBottomSheet({required this.order, Key? key, required this.index})
      : super(key: key);

  @override
  State<EditOrderBottomSheet> createState() => _EditOrderBottomSheetState();
}

class _EditOrderBottomSheetState extends State<EditOrderBottomSheet> {
  late final ProductDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<ProductDetailBloc>()
      ..add(ProductDetailLoadUpdating(widget.order));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Wrap(
        // child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close_rounded)),
              ),
              Text(
                widget.order.product.name!,
                style: AppStyle.mediumTitleStyleDark,
              ),
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close_rounded))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 4,
            color: Color(0xffEFEBE9),
          ),
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Customize",
                        style: AppStyle.mediumTextStyleDark.copyWith(
                            color: AppColor.headingColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Size",
                          style: AppStyle.normalTextStyleDark
                              .copyWith(color: AppColor.headingColor)),
                      const SizeFilter()
                    ],
                  ),
                ],
              )),
          Container(
            height: 4,
            color: Color(0xffEFEBE9),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Topping",
                      style: AppStyle.mediumTextStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.bold)),
                ),
                ToppingFilter()
              ],
            ),
          ),
          Container(
            height: 4,
            color: Color(0xffEFEBE9),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("Note",
                      style: AppStyle.mediumTextStyleDark.copyWith(
                          color: AppColor.headingColor,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 16,
                ),
                const NoteOpt(),
              ],
            ),
          ),
          Container(
            height: 12,
            color: Color(0xffEFEBE9),
          ),
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoadSuccess) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _bloc.add(
                                  ProductDetailDecreaseQuantityAndDelete());
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(4),
                              backgroundColor:
                                  Color(0xffBCAAA4), // <-- Button color
                            ),
                            child: Icon(
                              Icons.remove,
                              color: AppColor.primaryColor,
                              size: 18,
                            ),
                          ),
                          BlocBuilder<ProductDetailBloc, ProductDetailState>(
                            builder: (context, state) {
                              if (state is ProductDetailLoadSuccess) {
                                return Text(state.order.quantity.toString(),
                                    style: AppStyle.mediumTitleStyleDark);
                              } else {
                                return SizedBox();
                              }
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductDetailBloc>()
                                  .add(ProductDetailIncreaseQuantity());
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(4),
                              backgroundColor:
                                  Color(0xffBCAAA4), // <-- Button color
                            ),
                            child: Icon(
                              Icons.add,
                              color: AppColor.primaryColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              context.read<CartBloc>().add(CartUpdateItem(
                                  updatedOrder: state.order,
                                  index: widget.index));
                              Navigator.pop(context);
                            },
                            style: AppStyle.elevatedButtonStylePrimary,
                            child: Text(state.order.quantity == 0
                                ? "Remove this product"
                                : "Update ${FormatUtil.formatMoney(state.order.total)}")),
                      )
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
        // ),
      ),
    );
  }
}
