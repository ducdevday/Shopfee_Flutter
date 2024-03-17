part of product_by_category;

class ProductByCategoryBottom extends StatelessWidget {
  const ProductByCategoryBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          // if (state.cart.orders.isEmpty) {
          //   return SizedBox();
          // }
          return InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              height: 56,
              padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.cart.totalQuantity} item",
                          style: AppStyle.mediumTitleStyle
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        Visibility(
                          visible:
                              state.cart.nameOrderString.isEmpty ? false : true,
                          maintainSize:
                              state.cart.nameOrderString.isEmpty ? false : true,
                          maintainAnimation:
                              state.cart.nameOrderString.isEmpty ? false : true,
                          maintainState:
                              state.cart.nameOrderString.isEmpty ? false : true,
                          child: Text(
                            state.cart.nameOrderString,
                            style: AppStyle.smallTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(FormatUtil.formatMoney(state.cart.totalItemPrice),
                          style: AppStyle.mediumTitleStyle
                              .copyWith(fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 4,
                      ),
                      SvgPicture.asset(AppPath.icShoppingBag)
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
    return SizedBox();
  }
}
