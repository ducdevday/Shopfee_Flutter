part of product_detail;

class ViewedProductList extends StatelessWidget {
  const ViewedProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess &&
            state.viewedProducts.isNotEmpty) {
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
                          "Recently View Products",
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
                        itemCount: state.viewedProducts.length,
                        itemBuilder: (context, index) => HomeProduct(
                          product: state.viewedProducts[index],
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
