part of cart;

class CouponAppliedWidget extends StatelessWidget {
  const CouponAppliedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Coupon",
              style: AppStyle.mediumTitleStyleDark),
            SizedBox(
              height: 4,
            ),
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
      },
    );
  }
}
