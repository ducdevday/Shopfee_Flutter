part of cart;

class TimeSetter extends StatefulWidget {
  const TimeSetter({
    super.key,
  });

  @override
  State<TimeSetter> createState() => _TimeSetterState();
}

class _TimeSetterState extends State<TimeSetter> {
  Time _time = Time(hour: 11, minute: 30);

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
      DateTime chosenTime = DateTime.now();
      chosenTime = chosenTime.copyWith(hour: _time.hour, minute: _time.minute);
      context.read<CartBloc>().add(CartChooseTime(
              receiveTime:chosenTime));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.orderType == OrderType.ONSITE) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  showPicker(
                    iosStylePicker: true,
                    accentColor: Color(0xff8D6E63),
                    context: context,
                    value: _time,
                    minHour: 8,
                    maxHour: 20,
                    onChange: onTimeChanged,
                    minuteInterval: TimePickerInterval.FIFTEEN,
                    // Optional onChange to receive value as DateTime
                    onChangeDateTime: (DateTime dateTime) {
                      // print(dateTime);
                      debugPrint("[debug datetime]:  $dateTime");
                    },
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.cart.receiveTime == null
                        ? "As soon as posible"
                        : "Today",
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
                                ? "Now - 10 Minute"
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
