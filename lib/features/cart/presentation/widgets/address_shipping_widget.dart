part of cart;

class AddressShippingWidget extends StatelessWidget {
  const AddressShippingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if(state is CartLoaded){
          if(state.cart.address != null) {
            return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, AppRouter.savedAddressRoute,
              //     arguments: true)
              //     .then((value) =>
              //     context.read<CartBloc>().add(ChooseAddress(value as String)));
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            state.cart.address!.recipientName!,
                            style: AppStyle.mediumTextStyleDark
                                .copyWith(color: AppColor.headingColor),
                          ),
                          Text(
                            "  |  ",
                            style: AppStyle.normalTextStyleDark,
                          ),
                          Text(
                            state.cart.address!.phoneNumber!,
                            style: AppStyle.normalTextStyleDark,
                          ),
                        ],
                      ),
                      Text(
                        state.cart.address!.detail ?? "",
                        style: AppStyle.normalTextStyleDark,
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
          }
          else{
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, NewAddressPage.route).then((refresh) {
                  if (refresh != null && refresh == true) {
                    context.read<CartBloc>().add(CartInitAddress());
                  }
                });
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Please create an address",
                      style: AppStyle.normalTextStylePrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Icon(Icons.keyboard_arrow_right_rounded),
                ],
              ),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
