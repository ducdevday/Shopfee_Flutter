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
                        onPressed: () {},
                        icon: const Icon(Icons.close_rounded)),
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
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: PaymentType.values.mapIndexed((index, type) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Image.asset(
                              PaymentType.getIconPath(
                                  PaymentType.values[index]),
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Expanded(
                                child: Text(PaymentType.getFormattedName(
                                    PaymentType.values[index]))),
                            Radio(
                                activeColor: AppColor.primaryColor,
                                value: PaymentType.values[index],
                                groupValue: state.cart.paymentType,
                                onChanged: (PaymentType? value) {
                                  context.read<CartBloc>().add(
                                      CartChooseTypePayment(
                                          typePayment: value!));
                                  Navigator.pop(context);
                                })
                          ],
                        ),
                      ),
                      if (index < PaymentType.values.length - 1)
                        const Divider(
                          height: 10,
                          indent: 10,
                          endIndent: 10,
                        ),
                    ],
                  );
                }).toList(),
              ),
            ],
            // ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
