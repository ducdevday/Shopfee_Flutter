part of cart;

class TimeSetter extends StatelessWidget {
  const TimeSetter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orderType == OrderType.ONSITE &&
              state.cart.isTakeAwayOrderValid()) {
            DateTime openTime =
                FormatUtil.formatOpenCloseTime(state.cart.store!.openTime!);
            DateTime closeTime =
                FormatUtil.formatOpenCloseTime(state.cart.store!.closeTime!);
            return InkWell(
              onTap: () {
                BottomPicker.dateTime(
                  titlePadding: EdgeInsets.only(top: AppDimen.spacing),
                  titleAlignment: Alignment.center,
                  onSubmit: (date) {
                    context
                        .read<CartBloc>()
                        .add(CartChooseTime(receiveTime: date));
                  },
                  minDateTime: openTime,
                  maxDateTime: closeTime,
                  initialDateTime: state.cart.receiveTime ?? FormatUtil.addTenMinutes(DateTime.now()),
                  buttonSingleColor: AppColor.primaryColor,
                  pickerTitle: Text(R.chooseTime.tr(),
                      style: AppStyle.mediumTextStyleDark),
                ).show(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.cart.receiveTime == null
                        ? R.assoon.tr()
                        : R.today.tr(),
                    style: AppStyle.mediumTextStyleDark.copyWith(
                        color: AppColor.headingColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                            state.cart.receiveTime == null
                                ? R.tenMinute.tr()
                                : FormatUtil.formatTime(state.cart.receiveTime),
                            style: AppStyle.normalTextStyleDark),
                      ),
                      const Icon(Icons.keyboard_arrow_right_rounded)
                    ],
                  ),
                ],
              ),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
