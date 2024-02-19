part of cart;

class AddressEmptyWidget extends StatelessWidget {
  const AddressEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context,
        //     AppRouter.newAddressRoute)
        //     .then((value) => context.read<CartBloc>()
        //     .add(InitAddress()));
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
          const Icon(
              Icons.keyboard_arrow_right_rounded),
        ],
      ),
    );
  }
}