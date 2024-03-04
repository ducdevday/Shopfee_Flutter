part of cart;

class DeliveryBottomSheet extends StatelessWidget {
  const DeliveryBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if(state is CartLoaded){
          return Wrap(
            // child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.close_rounded)),
                  ),
                  Text(
                    "Choose Order Method",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  context.read<CartBloc>().add(
                      const CartChooseOrderType(typeOrder: OrderType.SHIPPING)
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: state.cart.orderType == OrderType.SHIPPING ? AppColor.primaryColor.withAlpha(30) : null,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_delivery.svg",
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Home Delivery",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Radio<OrderType>(
                          activeColor: AppColor.primaryColor,
                          value: OrderType.SHIPPING,
                          groupValue: state.cart.orderType,
                          onChanged: (OrderType? value) {
                            context.read<CartBloc>().add(
                              const CartChooseOrderType(typeOrder: OrderType.SHIPPING)
                            );
                          })
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  context.read<CartBloc>().add(
                      const CartChooseOrderType(typeOrder: OrderType.ONSITE)
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: state.cart.orderType == OrderType.ONSITE ? AppColor.primaryColor.withAlpha(30) : null,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/ic_take_away.svg",
                        width: 60,
                        height: 60,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "Take Away",
                          style: AppStyle.mediumTitleStyleDark
                              .copyWith(fontSize: 14),
                        ),
                      ),
                      Radio<OrderType>(
                          activeColor: AppColor.primaryColor,
                          value: OrderType.ONSITE,
                          groupValue: state.cart.orderType,
                          onChanged: (OrderType? value) {
                            context.read<CartBloc>().add(
                                const CartChooseOrderType(typeOrder: OrderType.ONSITE)
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
            // ),
          );
        }
        return const SizedBox();
      },
    );
  }
}