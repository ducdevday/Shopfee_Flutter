part of cart;

class AddressShippingWidget extends StatelessWidget {
  const AddressShippingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orderType == OrderType.SHIPPING) {
            if (state.cart.address != null) {
              return GestureDetector(
                onTap: () {
                  NavigationUtil.pushNamed(SavedAddressPage.route,
                          arguments: CartPage.route)
                      .then((addressId) => {
                            if (addressId != null)
                              context.read<CartBloc>().add(
                                  CartChooseShippingAddress(
                                      addressId: addressId as String))
                          });
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.account_circle_outlined, size: AppDimen.smallSize,color: AppColor.primaryColor,),
                                  SizedBox(width: AppDimen.smallSpacing,),
                                  Expanded(
                                    child: Text(
                                      "${state.cart.address?.recipientName} | ${state.cart.address?.phoneNumber}",
                                      style: AppStyle.mediumTextStyleDark
                                          .copyWith(color: AppColor.headingColor),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${state.cart.address?.detail}",
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
                    if (state.cart.shippingFee == null)
                      Text(
                        "This address can't serve your current location and time, please choose another",
                        style: AppStyle.normalTextStylePrimary.copyWith(color: AppColor.error),
                      )
                  ],
                ),
              );
            } else {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, NewAddressPage.route)
                      .then((refresh) {
                    if (refresh != null && refresh == true) {
                      context.read<CartBloc>().add(CartInitAddressAndReceiver());
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
        }
        return const SizedBox();
      },
    );
  }
}
