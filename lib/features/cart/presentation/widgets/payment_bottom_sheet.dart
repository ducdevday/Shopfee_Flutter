part of cart;

class PaymentBottomSheet extends StatefulWidget {
  const PaymentBottomSheet({
    super.key,
  });

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
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
                        onPressed: () {}, icon: Icon(Icons.close_rounded)),
                  ),
                  Text(
                    "Choose Payment Method",
                    style: AppStyle.mediumTitleStyleDark,
                  ),
                  IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close_rounded))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      AppPath.icCash,
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(child: Text("Cash")),
                    Radio(
                        activeColor: AppColor.primaryColor,
                        value: PaymentType.CASHING,
                        groupValue: state.cart.typePayment,
                        onChanged: (PaymentType? value) {
                          context.read<CartBloc>().add(CartChooseTypePayment(value!));
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              Divider(
                height: 10,
                indent: 10,
                endIndent: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Image.asset(
                      AppPath.icVnPay,
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(child: Text("VNPAY")),
                    Radio(
                        activeColor: AppColor.primaryColor,
                        value: PaymentType.BANKING,
                        groupValue: state.cart.typePayment,
                        onChanged: (PaymentType? value) {
                          context.read<CartBloc>().add(CartChooseTypePayment(value!));
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ],
            // ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
