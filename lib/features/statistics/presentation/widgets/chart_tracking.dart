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
              "Tracking Payment",
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
                      firstDate: CalculateUtil.getDateTime31DaysAgo(),
                      lastDate: DateTime.now(),
                      currentDate: DateTime.now()),
                  dialogSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 400),
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
              child: MyContainer(
                child: Row(
                  children: [
                    Text(
                        "${FormatUtil.formatDate3(dateTimes.first)}-${FormatUtil.formatDate3(dateTimes.last)}"),
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
                  primaryYAxis: NumericAxis(
                    numberFormat:
                        NumberFormat.currency(locale: 'vi_VN', symbol: '₫'),
                  ),
                  trackballBehavior: TrackballBehavior(
                    activationMode: ActivationMode.singleTap,
                    enable: true,
                  ),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    zoomMode: ZoomMode.x,
                    enablePanning: true,
                    enableDoubleTapZooming: true,
                  ),
                  series: <CartesianSeries>[
                    // Renders line chart
                    LineSeries<ChartLineData, DateTime>(
                      dataSource: widget.chartData,
                      xValueMapper: (ChartLineData data, _) => data.time,
                      yValueMapper: (ChartLineData data, _) => data.value,
                    ),
                  ]),
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
