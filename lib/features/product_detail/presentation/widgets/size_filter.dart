part of product_detail;

class SizeFilter extends StatelessWidget {
  const SizeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadSuccess) {
          print("Size: ${state.order.size}");
          return Row(
            children: state.order.product.sizeList!
                .map((s) => Row(
              children: [
                FilterChip(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: AppColor.primaryColor,
                        width: 2.0,
                      ),
                    ),
                    backgroundColor: state.order.size == s
                        ? AppColor.primaryColor
                        : Colors.white,
                    label: Text(
                      s.size,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.order.size == s
                              ? Colors.white
                              : AppColor.primaryColor),
                    ),
                    color: MaterialStateProperty.all(
                        state.order.size == s
                            ? AppColor.primaryColor
                            : Colors.white),
                    selected: state.order.size == s,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<ProductDetailBloc>().add(ProductDetailChooseSize(s));
                      }
                    }),
                SizedBox(width: 4,)
              ],
            ))
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}