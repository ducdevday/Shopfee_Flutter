part of statistics;

class ChartTracking extends StatefulWidget {
  final double total;
  final List<ChartLineData> chartData;

  const ChartTracking(
      {super.key, required this.total, required this.chartData});

  @override
  State<ChartTracking> createState() => _ChartTrackingState();
}

class _ChartTrackingState extends State<ChartTracking> {
  late TooltipBehavior _tooltipBehavior;
  late List<DateTime?> dateTimes;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    dateTimes = [widget.chartData.first.time, widget.chartData.last.time];
  }

  bool checkValidTracking(List<DateTime?>? result) {
    if (result == null) {
      return false;
    }
    if (result.length != 2) {
      return false;
    }
    if (CalculateUtil.distanceBetween2Date(result[0]!, result[1]!) > 31) {
      AlertUtil.showToast("Maxium 31 days");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              "Tracking Amount Paid",
              style: AppStyle.mediumTitleStyleDark,
            )),
            InkWell(
              onTap: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                      calendarType: CalendarDatePicker2Type.range,
                      centerAlignModePicker: true,
                      selectedRangeHighlightColor: AppColor.secondaryColor,
                      selectedDayHighlightColor: AppColor.primaryColor,
                      dayBorderRadius: BorderRadius.all(
                          Radius.circular(AppDimen.smallRadius)),
                      lastDate: DateTime.now(),
                      currentDate: DateTime.now()),
                  dialogSize: const Size(325, 400),
                  value: dateTimes,
                  borderRadius: BorderRadius.circular(15),
                );
                if (results != null) {
                  dateTimes = results;
                  context
                      .read<StatisticsBloc>()
                      .add(StatisticsChooseTracking(dateTimes: results));
                }
              },
              child: const MyContainer(
                child: Row(
                  children: [
                    Text("Time"),
                    SizedBox(
                      width: AppDimen.smallSpacing,
                    ),
                    Icon(
                      Icons.calendar_today,
                      size: AppDimen.xSmallSize,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: AppDimen.spacing,
        ),
        MyContainer(
          child: Column(
            children: [
              SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  series: <CartesianSeries>[
                    // Renders line chart
                    LineSeries<ChartLineData, DateTime>(
                      dataSource: widget.chartData,
                      xValueMapper: (ChartLineData data, _) => data.time,
                      yValueMapper: (ChartLineData data, _) => data.value,
                    ),
                  ]),
              Row(
                children: [
                  Expanded(child: Text("Chosen Start Date")),
                  Expanded(
                      child: Text(
                    "${FormatUtil.formatDate2(dateTimes.first)}",
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
              Row(
                children: [
                  Expanded(child: Text("Chosen End Date")),
                  Expanded(
                      child: Text(
                    "${FormatUtil.formatDate2(dateTimes.last)}",
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
              SizedBox(
                height: AppDimen.spacing,
              ),
              Row(
                children: [
                  Expanded(child: Text("Total Payment")),
                  Expanded(
                      child: Text(
                    "${FormatUtil.formatMoney(widget.total)}",
                    textAlign: TextAlign.end,
                  ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
