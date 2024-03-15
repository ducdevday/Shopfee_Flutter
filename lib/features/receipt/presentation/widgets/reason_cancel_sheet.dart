part of receipt;

class ReasonCancelSheet extends StatelessWidget {
  const ReasonCancelSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoadSuccess) {
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
                    "Choose Reason For Cancel",
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
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          context.read<ReceiptBloc>().add(ChooseReasonCancel(
                              reasonCancel: ReasonCancelType.values[index]));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(ReasonCancelType.getString(
                                      ReasonCancelType.values[index]))),
                              const SizedBox(
                                width: 4,
                              ),
                              Radio<ReasonCancelType>(
                                  activeColor: AppColor.primaryColor,
                                  value: ReasonCancelType.values[index],
                                  groupValue: state.reasonCancel,
                                  onChanged: (ReasonCancelType? value) {
                                    // context
                                    //     .read<ReceiptBloc>()
                                    //     .add(ChooseReasonCancel(reason: value!));
                                    context.read<ReceiptBloc>().add(
                                        ChooseReasonCancel(
                                            reasonCancel: ReasonCancelType
                                                .values[index]));
                                  })
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        height: 10,
                        indent: 10,
                        endIndent: 10,
                      ),
                  itemCount: ReasonCancelType.values.length),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child: ElevatedButton(
                    onPressed: state.reasonCancel == null
                        ? null
                        : () {
                            showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) =>
                                    MyConfirmDialog(
                                      title: "Confirm",
                                      content:
                                          "Are you sure to cancel this order",
                                      callbackOK: () {
                                        context
                                            .read<ReceiptBloc>()
                                            .add(ReceiptDoCancelOrder(
                                              orderId: state.receipt.id!,

                                            ));
                                        Navigator.pop(dialogContext);
                                      },
                                      callbackCancel: () {
                                        Navigator.pop(dialogContext);
                                      },
                                      confirmText: "Yes",
                                    )).then((value) => Navigator.pop(context));
                          },
                    child: const Text("Confirm Cancel"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.error,
                        disabledBackgroundColor: const Color(0xffCACACA),
                        disabledForegroundColor: AppColor.lightColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                  ))
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
