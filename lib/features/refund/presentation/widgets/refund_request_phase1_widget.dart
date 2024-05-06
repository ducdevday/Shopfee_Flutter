part of refund;

class RefundRequestPhase1Widget extends StatelessWidget {
  final List<File> mediaList;
  final String note;

  const RefundRequestPhase1Widget(
      {super.key, required this.mediaList, required this.note});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefundBloc, RefundState>(
      builder: (context, state) {
        if (state is RefundRequestPhase1State) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What problem do you have with your order?",
                style: AppStyle.mediumTextStyleDark,
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: AppDimen.smallPadding),
                shrinkWrap: true,
                itemBuilder: (context, index) => RefundReasonWidget(
                    reasonRefundType: ReasonRefundType.values.elementAt(index),
                    currentType: state.reasonRefundType,
                    callback: (ReasonRefundType? reasonChosen) {
                      if (reasonChosen != null) {
                        context.read<RefundBloc>().add(
                            RefundChooseReasonPressed(
                                reasonRefundType: reasonChosen));
                      }
                    }),
                itemCount: ReasonRefundType.values.length,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.reasonRefundType == null
                      ? null
                      : () {
                          context.read<RefundBloc>().add(RefundContinuePressed(
                              chosenReason: state.reasonRefundType!,
                              mediaList: mediaList,
                              note: note));
                        },
                  child: Text("Continue"),
                  style: AppStyle.elevatedButtonStyleRed,
                ),
              )
            ],
          );
        }
        return SizedBox();
      },
    );
  }
}
