import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/features/receipt/bloc/receipt_bloc.dart';
import 'package:shopfee/app/features/receipt/widgets/reason_cancel_sheet.dart';
import 'package:shopfee/data/models/status_order.dart';

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
          child: ReasonCancelSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptBloc, ReceiptState>(
      builder: (context, state) {
        if (state is ReceiptLoaded && state.eventLog.orderStatus == OrderStatus.CREATED) {
          return Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      buildShowReasonCancelSheet(context);
                    },
                    child: Text("Cancel Order"),
                  )),
              Divider(
                height: 20,
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
