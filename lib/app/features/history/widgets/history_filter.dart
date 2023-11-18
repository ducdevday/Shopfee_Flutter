import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:shopfee/app/features/history/bloc/history_bloc.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';

class HistoryFilter extends StatelessWidget {
  const HistoryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      buildWhen: (previousState, state) => state is! HistoryLoading,
      builder: (context, state) {
        if (state is HistoryLoaded) {
          return Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            child: Row(
              children: [
                FilterChip(
                    labelPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      HistoryStatus.Processing.name,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.historyStatus == HistoryStatus.Processing
                              ? Colors.white
                              : AppColor.headingColor),
                    ),
                    selected: state.historyStatus == HistoryStatus.Processing,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<HistoryBloc>().add(const LoadHistory(
                            historyStatus: HistoryStatus.Processing));
                      }
                    }),
                const SizedBox(width: 8),
                FilterChip(
                    labelPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      HistoryStatus.Done.name,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.historyStatus == HistoryStatus.Done
                              ? Colors.white
                              : AppColor.headingColor),
                    ),
                    selected: state.historyStatus == HistoryStatus.Done,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<HistoryBloc>().add(const LoadHistory(
                            historyStatus: HistoryStatus.Done));
                      }
                    }),
                const SizedBox(width: 8),
                FilterChip(
                    labelPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    showCheckmark: false,
                    selectedColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    label: Text(
                      HistoryStatus.Canceled.name,
                      style: AppStyle.smallTextStyleDark.copyWith(
                          fontWeight: FontWeight.bold,
                          color: state.historyStatus == HistoryStatus.Canceled
                              ? Colors.white
                              : AppColor.headingColor),
                    ),
                    selected: state.historyStatus == HistoryStatus.Canceled,
                    onSelected: (bool selected) {
                      if (selected) {
                        context.read<HistoryBloc>().add(const LoadHistory(
                            historyStatus: HistoryStatus.Canceled));
                      }
                    }),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
