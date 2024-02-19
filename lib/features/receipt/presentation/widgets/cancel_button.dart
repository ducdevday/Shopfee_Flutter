part of receipt;

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  Future<void> buildShowReasonCancelSheet(
      BuildContext context) {
    return showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ReceiptBloc>(),
          child: const ReasonCancelSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess && state.lastEventLog.orderStatus == OrderStatus.CREATED) {
          return Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      buildShowReasonCancelSheet(context);
                    },
                    child: const Text("Cancel Order"),
                  )),
              const Divider(
                height: 20,
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
