part of refund;

class RefundReasonWidget extends StatelessWidget {
  final ReasonRefundType reasonRefundType;
  final ReasonRefundType? currentType;
  final Function(ReasonRefundType?) callback;

  const RefundReasonWidget(
      {super.key,
      required this.reasonRefundType,
      this.currentType,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                reasonRefundType.getString(),
                style: AppStyle.normalTextStyleDark,
              ),
            ),
            MyRadio<ReasonRefundType>(
              value: reasonRefundType,
              groupValue: currentType,
              onChanged: (ReasonRefundType? value) {
                callback(value);
              },
            ),
          ],
        ),
        Divider(),
        SizedBox(height: AppDimen.smallPadding,)
      ],
    );
  }
}
