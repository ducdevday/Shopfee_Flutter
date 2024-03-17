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
              style: AppStyle.mediumTitleStyleDark.copyWith(
                  color: AppColor.headingColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Icon(
                  Icons.discount,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text("Add coupon",
                      style: AppStyle.normalTextStylePrimary),
                ),
                Icon(Icons.keyboard_arrow_right_rounded)
              ],
            ),
          ],
        );
      },
    );
  }
}
