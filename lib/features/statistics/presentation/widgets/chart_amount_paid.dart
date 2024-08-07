part of statistics;

class ChartAmountPaid extends StatefulWidget {
  final double total;
  final List<ChartCircularData> chartData;

  const ChartAmountPaid(
      {super.key, required this.total, required this.chartData});

  @override
  State<ChartAmountPaid> createState() => _ChartAmountPaidState();
}

class _ChartAmountPaidState extends State<ChartAmountPaid> {
  bool isShowLabel = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              R.amountPaidBy.tr(),
              style: AppStyle.mediumTitleStyleDark,
            )),
        SizedBox(
          height: AppDimen.spacing,
        ),
        MyContainer(
          child: Column(
            children: [
              SfCircularChart(
                  palette: <Color>[
                    AppColor.circularChartColor2,
                    AppColor.circularChartColor1,
                    AppColor.circularChartColor3,
                    AppColor.circularChartColor4
                  ],
                  legend:
                  Legend(isVisible: true, position: LegendPosition.bottom),
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: Text(
                          '${R.total.tr()}\n${FormatUtil.formatMoney(widget.total)}',
                          style: AppStyle.largeTitleStyleDark,
                          textAlign: TextAlign.center,))
                  ],
                  series: <CircularSeries<ChartCircularData, String>>[
                    DoughnutSeries<ChartCircularData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: widget.chartData,
                        onPointTap: (value) {
                          setState(() {
                            isShowLabel = true;
                          });
                        },
                        xValueMapper: (ChartCircularData data, _) => data.xData,
                        yValueMapper: (ChartCircularData data, _) => data.yData,
                        dataLabelMapper: (ChartCircularData data, _) =>
                        data.text,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: isShowLabel,
                            textStyle: AppStyle.normalTextStyle.copyWith(
                                shadows: [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1))
                                ])),
                        innerRadius: '70%'
                    ),
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}
