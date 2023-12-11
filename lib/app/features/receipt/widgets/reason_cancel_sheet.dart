import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/data/models/event_log.dart';
import 'package:shopfee/data/models/status_order.dart';

final List<String> reasons = const [
  "I want to update address",
  "I want to update products",
  "I don't want to buy anymore",
  "I couldn't find a reasonable reason to cancel",
];

class ReasonCancelSheet extends StatelessWidget {
  const ReasonCancelSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoaded) {
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
                          context
                              .read<ReceiptBloc>()
                              .add(ChooseReasonCancel(reason: reasons[index]));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Expanded(child: Text(reasons[index])),
                              const SizedBox(
                                width: 4,
                              ),
                              Radio<String>(
                                  activeColor: AppColor.primaryColor,
                                  value: reasons[index],
                                  groupValue: state.reasonCancel,
                                  onChanged: (String? value) {
                                    // context
                                    //     .read<ReceiptBloc>()
                                    //     .add(ChooseReasonCancel(reason: value!));
                                    context.read<ReceiptBloc>().add(
                                        ChooseReasonCancel(
                                            reason: reasons[index]));
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
                  itemCount: reasons.length),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(AppDimen.spacing),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) =>
                              MyConfirmDialog(
                                title: "Confirm",
                                content: "Are you sure to cancel this order",
                                callbackOK: () {
                                  context.read<ReceiptBloc>().add(AddEventLog(
                                      orderId: state.receipt.id!,
                                      eventLog: EventLog(
                                          OrderStatus.CANCELED,
                                          DateTime.now(),
                                          state.reasonCancel,
                                          false)));
                                  //! Rebuild UI
                                  context.read<HistoryBloc>().add(
                                      const LoadHistory(
                                          historyStatus:
                                              HistoryStatus.Processing));
                                  Navigator.pop(dialogContext);
                                },
                                callbackCancel: () {
                                  Navigator.pop(dialogContext);
                                },
                                confirmText: "Yes",
                              )).then((value) => Navigator.pop(context));
                    },
                    child: const Text("Confirm Cancel"),
                    style: AppStyle.elevatedButtonStylePrimary.copyWith(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.error)),
                  ))
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
