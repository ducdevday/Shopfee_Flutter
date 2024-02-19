part of history;

class HistoryFilter extends StatelessWidget {
  const HistoryFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryStatus historyStatus = HistoryStatus.Processing;

    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryLoaded) {
          historyStatus = state.historyStatus;
        }
      },
      builder: (context, state) {
        return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            child: Row(
              children: HistoryStatus.values
                  .mapIndexed((index, status) => Row(
                        children: [
                          FilterChip(
                              // labelPadding: const EdgeInsets.symmetric(
                              //     vertical: 4, horizontal: 8),
                              showCheckmark: false,
                              selectedColor: AppColor.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: AppColor.primaryColor,
                                  width: 1.5,
                                ),
                              ),
                              label: Text(
                                HistoryStatus.values[index].name,
                                style: AppStyle.smallTextStyleDark.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: historyStatus ==
                                            HistoryStatus.values[index]
                                        ? Colors.white
                                        : AppColor.headingColor),
                              ),
                              color: MaterialStateProperty.all(
                                  historyStatus ==
                                      HistoryStatus.values[index]
                                      ? AppColor.primaryColor
                                      : Colors.white),
                              selected:
                                  historyStatus == HistoryStatus.values[index],
                              onSelected: (bool selected) {
                                if (selected) {
                                  context.read<HistoryBloc>().add(LoadHistory(
                                      historyStatus:
                                          HistoryStatus.values[index]));
                                }
                              }),
                          if (index < HistoryStatus.values.length - 1)
                            const SizedBox(width: 8),
                        ],
                      ))
                  .toList(),
            ));
      },
    );
  }
}
