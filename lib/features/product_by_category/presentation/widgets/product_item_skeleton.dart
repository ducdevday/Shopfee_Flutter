part of product_by_category;

class ProductItemSkeleton extends StatelessWidget {
  const ProductItemSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyShimmerCircle(
            height: 70,
            width: 70,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyShimmerRectangle(
                    width: 200,
                    height: 20,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  MyShimmerRectangle(
                    width: 300,
                    height: 30,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: MyShimmerRectangle(
              width: 65,
              height: 20,
            ),
          )
        ],
      ),
    );
  }
}
