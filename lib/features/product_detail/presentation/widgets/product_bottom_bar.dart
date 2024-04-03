part of product_detail;

class ProductBottomBar extends StatelessWidget {
  const ProductBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess) {
          return Stack(
            children: [
              BottomAppBar(
                // height: 70,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppDimen.spacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          Text(
                            FormatUtil.formatMoney(state.order.total),
                            style: AppStyle.largeTitleStyleDark,
                          )
                        ],
                      ),
                      buildElevatedButton(context, state)
                    ],
                  ),
                ),
              ),
              if (state.order.product.status == ProductStatus.OUT_OF_STOCK)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                          0.5), // Adjust opacity and color as needed
                    ),
                  ),
                ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildElevatedButton(
      BuildContext context, ProductDetailLoadSuccess state) {
    if (state.order.product.status == ProductStatus.AVAILABLE) {
      return ElevatedButton(
          onPressed: () {
            context.read<CartBloc>().add(CartAddItem(order: state.order));
            EasyLoading.showSuccess("Item has been add into cart");
            Navigator.pop(context);
          },
          style: AppStyle.elevatedButtonStylePrimary,
          child: const Text("Add To Cart"));
    } else {
      return SizedBox();
    }
  }
}
