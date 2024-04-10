part of statistics;

class ChartAmountPaid extends StatelessWidget {
  final double total;
  final List<ChartCircularData> chartData;

  const ChartAmountPaid(
      {super.key, required this.total, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Amount Paid',
              style: AppStyle.mediumTitleStyleDark,
            )),
        SizedBox(height: AppDimen.spacing,),
        MyContainer(
          child: Column(
            children: [
              SfCircularChart(
                  legend:
                      Legend(isVisible: true, position: LegendPosition.bottom),
                  series: <CircularSeries<ChartCircularData, String>>[
                    DoughnutSeries<ChartCircularData, String>(
                        explode: true,
                        explodeIndex: 0,
                        dataSource: chartData,
                        xValueMapper: (ChartCircularData data, _) => data.xData,
                        yValueMapper: (ChartCircularData data, _) => data.yData,
                        dataLabelMapper: (ChartCircularData data, _) =>
                            data.text,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ]),
            ],
          ),
        ),
      ],
    );
  }
}
