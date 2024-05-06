part of product_detail;

class SizeFilter extends StatelessWidget {
  const SizeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess) {
          final sizeList = state.order.product.sizeList;
          if (sizeList != null && sizeList.isNotEmpty) {
            return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColor.scaffoldColorBackground, width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.shadowColor,
                          spreadRadius: 0,
                          blurRadius: 1)
                    ]),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Customize",
                          style: AppStyle.mediumTextStyleDark.copyWith(
                              color: AppColor.headingColor,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text("Size",
                            style: AppStyle.normalTextStyleDark
                                .copyWith(color: AppColor.headingColor)),
                        SizedBox(
                          width: AppDimen.smallPadding,
                        ),
                        Expanded(
                            child: Wrap(
                          spacing: 4,
                          alignment: WrapAlignment.end,
                          children: sizeList
                              .map(
                                (s) => FilterChip(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    showCheckmark: false,
                                    selectedColor: AppColor.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                        color: AppColor.primaryColor,
                                        width: 2.0,
                                      ),
                                    ),
                                    backgroundColor: state.order.size == s
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    label: Text(
                                      FormatUtil.formatSize(s.size),
                                      style: AppStyle.smallTextStyleDark
                                          .copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: state.order.size == s
                                                  ? Colors.white
                                                  : AppColor.primaryColor),
                                    ),
                                    color: MaterialStateProperty.all(
                                        state.order.size == s
                                            ? AppColor.primaryColor
                                            : Colors.white),
                                    selected: state.order.size == s,
                                    onSelected: (bool selected) {
                                      if (selected) {
                                        context
                                            .read<ProductDetailBloc>()
                                            .add(ProductDetailChooseSize(s));
                                      }
                                    }),
                              )
                              .toList(),
                        ))
                      ],
                    ),
                  ],
                ));
          }
        }
        return SizedBox();
      },
    );
  }
}
