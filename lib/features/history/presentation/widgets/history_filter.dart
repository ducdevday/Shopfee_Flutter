part of history;

class HistoryFilter extends StatefulWidget {
  final HistoryStatus historyStatus;
  final int initPage;
  final int initSize;

  const HistoryFilter({
    super.key,
    required this.historyStatus,
    required this.initPage,
    required this.initSize,
  });

  @override
  State<HistoryFilter> createState() => _HistoryFilterState();
}

class _HistoryFilterState extends State<HistoryFilter> {
  late HistoryStatus historyStatus;

  @override
  void initState() {
    super.initState();
    historyStatus = widget.historyStatus;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (BuildContext context, HistoryState state) {
        if (state is HistoryLoadSuccess) {
          historyStatus = state.chosenStatus;
        }
      },
      builder: (BuildContext context, HistoryState state) {
        return SizedBox(
          height: 50,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppDimen.screenPadding),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => FilterChip(
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
                  HistoryStatus.getName(HistoryStatus.values[index]),
                  style: AppStyle.smallTextStyleDark.copyWith(
                      fontWeight: FontWeight.w600,
                      color: historyStatus == HistoryStatus.values[index]
                          ? Colors.white
                          : AppColor.headingColor),
                ),
                color: MaterialStateProperty.all(
                    historyStatus == HistoryStatus.values[index]
                        ? AppColor.primaryColor
                        : Colors.white),
                selected: historyStatus == HistoryStatus.values[index],
                onSelected: (bool selected) {
                  if (selected) {
                    setState(() {
                      historyStatus = HistoryStatus.values[index];
                    });
                    context.read<HistoryBloc>().add(
                        HistoryLoadInformationByStatus(
                            historyStatus: HistoryStatus.values[index],
                            initPage: widget.initPage,
                            initSize: widget.initSize));
                  }
                }),
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
            itemCount: HistoryStatus.values.length,
          ),
        );
      },
    );
  }
}
