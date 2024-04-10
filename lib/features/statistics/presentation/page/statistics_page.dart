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

  void handleMenuClick(String value) {
    switch (value) {
      case 'Amount Paid':
        _bloc.add(StatisticsChooseAmountPaid());
        break;
      case 'Order':
        _bloc.add(StatisticsChooseTotalOrder());
        break;
      case 'Tracking':
        _bloc.add(StatisticsChooseTracking(
            dateTimes: [CalculateUtil.getDateTime7DaysAgo(), DateTime.now()]));
        break;
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
            title: Text("Statistics"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(height: 1),
            ),
            actions: <Widget>[
              PopupMenuButton<String>(
                icon: SvgPicture.asset(AppPath.icStatistic),
                onSelected: handleMenuClick,
                itemBuilder: (BuildContext context) {
                  return {'Amount Paid', 'Order', 'Tracking'}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
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
