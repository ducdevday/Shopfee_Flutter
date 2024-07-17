part of statistics;

class StatisticsPage extends StatefulWidget {
  static const String route = "/statistics";

  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late StatisticsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ServiceLocator.sl<StatisticsBloc>()
      ..add(StatisticsChooseAmountPaid());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void handleMenuClick(StatisticsView value) {
    switch (value) {
      case StatisticsView.AMOUNT:
        _bloc.add(StatisticsChooseAmountPaid());
        break;
      case StatisticsView.ORDER:
        _bloc.add(StatisticsChooseTotalOrder());
        break;
      case StatisticsView.TRACKING:
        _bloc.add(StatisticsChooseTracking(dateTimes: [
          CalculateUtil.getDateTime7DaysAgo(),
          FormatUtil.addOneDay(DateTime.now())
        ]));
        break;
    }
  }

  String getStatisticViewName(StatisticsView value) {
    switch (value) {
      case StatisticsView.AMOUNT:
        return R.amountPaidBy.tr();
      case StatisticsView.ORDER:
        return R.order.tr();
      case StatisticsView.TRACKING:
        return R.trackingPayment.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
          backgroundColor: AppColor.scaffoldColorBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(R.statistics.tr()),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
            actions: <Widget>[
              PopupMenuButton<StatisticsView>(
                icon: SvgPicture.asset(AppPath.icStatistic),
                onSelected: handleMenuClick,
                itemBuilder: (BuildContext context) {
                  return StatisticsView.values.map((e) {
                    return PopupMenuItem<StatisticsView>(
                      value: e,
                      child: Text(getStatisticViewName(e)),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppDimen.screenPadding),
              child: Column(
                children: [
                  BlocBuilder<StatisticsBloc, StatisticsState>(
                    builder: (context, state) {
                      switch (state) {
                        case StatisticsAmountPaidState():
                          return ChartAmountPaid(
                              total: state.total, chartData: state.chartData);
                        case StatisticsTotalOrderState():
                          return ChartTotalOrder(
                              total: state.total, chartData: state.chartData);
                        case StatisticsTrackingState():
                          return ChartTracking(
                              total: state.total, chartData: state.chartData);
                      }
                      return SizedBox();
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

enum StatisticsView { AMOUNT, ORDER, TRACKING }
