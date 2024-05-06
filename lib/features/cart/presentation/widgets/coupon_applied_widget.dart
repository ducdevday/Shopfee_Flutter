part of cart;

class CouponAppliedWidget extends StatelessWidget {
  const CouponAppliedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Coupon", style: AppStyle.mediumTitleStyleDark),
              SizedBox(
                height: 4,
              ),
              buildShippingCoupon(state.cart.shippingCouponCode,
                  state.cart.shippingCouponResult),
              buildOrderCoupon(
                  state.cart.orderCouponCode, state.cart.orderCouponResult),
              buildProductCoupon(
                  state.cart.productCouponCode, state.cart.productCouponResult),
              TextButton.icon(
                  onPressed: () {
                    NavigationUtil.pushNamed(CouponInCartPage.route);
                  },
                  icon: Icon(
                    Icons.discount_outlined,
                  ),
                  label: Text("Add Coupon"))
            ],
          );
        }
        return SizedBox();
      },
    );
  }

  Widget buildShippingCoupon(String? shippingCouponCode,
      CouponCheckResultEntity? shippingCouponResult) {
    if (shippingCouponCode == null || shippingCouponResult == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Shipping Coupon",
          style: AppStyle.mediumTextStyleDark,
        ),
        Row(
          children: [
            Image.asset(
              shippingCouponResult!.couponType!.getIconType(),
              width: AppDimen.smallSize,
              height: AppDimen.smallSize,
            ),
            Expanded(
              child: Text(
                "${shippingCouponCode}",
                style: AppStyle.normalTextStyleDark,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                "${shippingCouponResult.reward?.getFormattedReward()}",
                style: AppStyle.normalTextStyleDark,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildOrderCoupon(
      String? orderCouponCode, CouponCheckResultEntity? orderCouponResult) {
    if (orderCouponCode == null || orderCouponResult == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Order Coupon",
          style: AppStyle.mediumTextStyleDark,
        ),
        Row(
          children: [
            Image.asset(
              orderCouponResult!.couponType!.getIconType(),
              width: AppDimen.smallSize,
              height: AppDimen.smallSize,
            ),
            Expanded(
              child: Text(
                "${orderCouponCode}",
                style: AppStyle.normalTextStyleDark,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                "${orderCouponResult.reward?.getFormattedReward()}",
                style: AppStyle.normalTextStyleDark,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildProductCoupon(
      String? productCouponCode, CouponCheckResultEntity? productCouponResult) {
    if (productCouponCode == null || productCouponResult == null) {
      return const SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Coupon",
          style: AppStyle.mediumTextStyleDark,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              productCouponResult!.couponType!.getIconType(),
              width: AppDimen.smallSize,
              height: AppDimen.smallSize,
            ),
            Expanded(
              child: Text(
                "${productCouponCode}",
                style: AppStyle.normalTextStyleDark,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Text(
                "${productCouponResult.reward?.getFormattedReward()}",
                style: AppStyle.normalTextStyleDark,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        )
      ],
    );
  }
}
