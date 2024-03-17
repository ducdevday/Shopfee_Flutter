part of cart;

class StoreWidget extends StatelessWidget {
  const StoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orderType == OrderType.ONSITE) {
            if (state.cart.store != null) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, StorePage.route, arguments: CartPage.route)
                      .then((branchId) {
                    if (branchId != null) {
                      context
                          .read<CartBloc>()
                          .add(CartChooseStore(branchId: branchId as String));
                    }
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.cart.store?.name}",
                            style: AppStyle.mediumTextStyleDark,
                          ),
                          Text(
                            "${state.cart.store?.fullAddress}",
                            style: AppStyle.normalTextStyleDark,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Icon(Icons.keyboard_arrow_right_rounded),
                  ],
                ),
              );
            } else {
              return Text(
                "There are no stores still operating",
                style: AppStyle.normalTextStyleDark,
              );
            }
          }
        }
        return const SizedBox();
      },
    );
  }
}
