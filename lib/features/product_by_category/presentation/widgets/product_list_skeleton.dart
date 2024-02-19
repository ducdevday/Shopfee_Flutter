part of product_by_category;

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:AppDimen.screenPadding),
            child: ProductItemSkeleton(),
          ),
        ),
        separatorBuilder: (context, int index) => Divider(
          height: 8,
          thickness: 0.75,
        ),
      ),
    );
  }
}