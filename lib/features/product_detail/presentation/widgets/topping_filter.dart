part of product_detail;

class ToppingFilter extends StatefulWidget {
  const ToppingFilter({Key? key}) : super(key: key);

  @override
  State<ToppingFilter> createState() => _ToppingFilterState();
}

class _ToppingFilterState extends State<ToppingFilter> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess) {
          final toppings = state.order.product.toppingList;
          if (toppings != null && toppings.isNotEmpty) {
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
                      child: Text(R.topping.tr(),
                          style: AppStyle.mediumTextStyleDark.copyWith(
                              color: AppColor.headingColor,
                              fontWeight: FontWeight.w600)),
                    ),
                    ListView.separated(
                      itemCount: toppings.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                toppings[index].name,
                                style: AppStyle.normalTextStyleDark
                                    .copyWith(color: AppColor.headingColor),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.add_rounded,
                                  size: 16,
                                ),
                                Text(
                                    FormatUtil.formatMoney(
                                        toppings[index].price),
                                    style: AppStyle.mediumTitleStylePrimary
                                        .copyWith(
                                            color: const Color(0xff3A3A3C))),
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                  activeColor: AppColor.primaryColor,
                                  value: state.order.toppings
                                      .contains(toppings[index]),
                                  onChanged: (bool? value) {
                                    context.read<ProductDetailBloc>().add(
                                        ProductDetailChooseTopping(
                                            toppings[index]));
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                    )
                  ],
                ));
          }
        }
        return const SizedBox();
      },
    );
  }
}
