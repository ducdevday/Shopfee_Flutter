part of product_detail;

class RecommendProductList extends StatelessWidget {
  const RecommendProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess &&
            state.recommendProducts.isNotEmpty) {
          return Column(
            children: [
              Container(
                height: AppDimen.spacing,
                color: AppColor.scaffoldColorBackground,
              ),
              MyContainer(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Recommend Products",
                          style: AppStyle.mediumTitleStyleDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppDimen.screenPadding),
                        itemCount: state.recommendProducts.length,
                        itemBuilder: (context, index) => HomeProduct(
                          product: state.recommendProducts[index],
                          viewType: ProductViewType.List_View_Horizontal,
                        ),
                        separatorBuilder: (context, int index) => const SizedBox(
                          width: AppDimen.spacing,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
