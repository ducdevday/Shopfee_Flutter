part of product_detail;

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              context.read<ProductDetailBloc>().add(ProductDetailDecreaseQuantity());
            },
            icon: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(6),
            constraints: BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
            ),
          ),
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoadSuccess) {
                return Container(
                    width: 32,
                    height: 32,
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: Text(state.order.quantity.toString(),
                        style: AppStyle.largeTitleStyleDark));
              } else {
                return SizedBox();
              }
            },
          ),
          IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              context.read<ProductDetailBloc>().add(ProductDetailIncreaseQuantity());
            },
            icon: Icon(Icons.add, color: Colors.white),
            padding: EdgeInsets.all(6),
            constraints: BoxConstraints(),
            style: const ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // the '2023' part
            ),
          )
        ],
      ),
    );
  }
}
