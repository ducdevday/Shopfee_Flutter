part of statistics;

class ChartTotalOrder extends StatelessWidget {
  final double total;
  final List<ChartCircularData> chartData;

  const ChartTotalOrder(
      {super.key, required this.total, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${R.total.tr()} ${R.order.tr()} (${total.toInt()})',
            style: AppStyle.mediumTitleStyleDark,
          ),
        ),
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
                  series: <CircularSeries<ChartCircularData, String>>[
                    PieSeries<ChartCircularData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: chartData,
                        xValueMapper: (ChartCircularData data, _) => data.xData,
                        yValueMapper: (ChartCircularData data, _) => data.yData,
                        dataLabelMapper: (ChartCircularData data, _) =>
                            data.text,
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: AppStyle.normalTextStyle.copyWith(
                                shadows: [
                                  Shadow(
                                      color: Colors.black45,
                                      offset: Offset(1, 1))
                                ]))),
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}
