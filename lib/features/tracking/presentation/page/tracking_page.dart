part of tracking;

class TrackingPage extends StatefulWidget {
  static const String route = "/tracking";
  final String orderId;

  const TrackingPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  late final TrackingCubit _cubit;
  late final List<EventLogEntity> eventlogs;

  @override
  void initState() {
    super.initState();
    _cubit = ServiceLocator.sl<TrackingCubit>()
      ..loadTrackingInformation(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Tracking"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          )),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocConsumer<TrackingCubit, TrackingState>(
          listener: (context, state) {
            if (state is TrackingLoadSuccess) {
              eventlogs = state.eventlogs;
            }
          },
          builder: (context, state) {
            if (state is TrackingLoadInProcess) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is TrackingLoadSuccess) {
              return Padding(
                padding: EdgeInsets.all(AppDimen.screenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ID Transaction",
                          style: AppStyle.mediumTitleStyleDark,
                        ),
                        Text(
                          widget.orderId,
                          style: AppStyle.normalTextStyleDark,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FixedTimeline.tileBuilder(
                            theme: TimelineThemeData(
                              nodePosition: 0,
                              color: Color(0xff989898),
                              indicatorTheme: IndicatorThemeData(
                                position: 0,
                                size: 12.0,
                              ),
                              connectorTheme: ConnectorThemeData(
                                thickness: 1,
                              ),
                            ),
                            builder: TimelineTileBuilder.connected(
                              itemExtent: 100.0,
                              connectionDirection: ConnectionDirection.before,
                              itemCount: eventlogs.length,
                              contentsBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      OrderStatus.getFormattedName(eventlogs[index].orderStatus),
                                      style: AppStyle.mediumTextStyleDark
                                          .copyWith(
                                              color: AppColor.primaryColor),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${FormatUtil.formatTime(eventlogs[index].time)} - ${FormatUtil.formatDate(eventlogs[index].time)}",
                                      style: AppStyle.smallTextStyleDark,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "${eventlogs[index].descriptionString}",
                                      style: AppStyle.normalTextStyleDark,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ],
                                ),
                              ),
                              indicatorBuilder: (_, index) {
                                if (eventlogs[index].orderStatus !=
                                    OrderStatus.SUCCEED) {
                                  return DotIndicator(
                                    color: AppColor.primaryColor,
                                  );
                                } else {
                                  return DotIndicator(
                                    color: AppColor.primaryColor,
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 10.0,
                                    ),
                                  );
                                }
                              },
                              connectorBuilder: (_, index, ___) =>
                                  DashedLineConnector(
                                color: AppColor.primaryColor,
                                thickness: 1.5,
                                dash: 1,
                                gap: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("See Order Detail"),
                              style: AppStyle.elevatedButtonStylePrimary),
                        ))
                  ],
                ),
              );
            } else {
              return MyErrorWidget();
            }
          },
        ),
      ),
    );
  }
}

class TrackingTimeline extends StatelessWidget {
  const TrackingTimeline({
    super.key,
    required this.tracks,
  });

  final List<Map<String, String>> tracks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineThemeData(
          nodePosition: 0,
          color: Color(0xff989898),
          indicatorTheme: IndicatorThemeData(
            position: 0,
            size: 20.0,
          ),
          connectorTheme: ConnectorThemeData(
            thickness: 2.5,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          itemExtent: 80.0,
          connectionDirection: ConnectionDirection.before,
          itemCount: tracks.length,
          contentsBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tracks[index]["title"]!,
                  style: AppStyle.mediumTextStyleDark
                      .copyWith(color: AppColor.headingColor),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  tracks[index]["time"]!,
                  style: AppStyle.smallTextStyleDark,
                )
              ],
            ),
          ),
          indicatorBuilder: (_, index) {
            if (index <= 2) {
              return DotIndicator(
                color: Color(0xff66c97f),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12.0,
                ),
              );
            } else {
              return OutlinedDotIndicator(
                borderWidth: 2.5,
              );
            }
          },
          connectorBuilder: (_, index, ___) => SolidLineConnector(
            color: index <= 2 ? Color(0xff66c97f) : null,
          ),
        ),
      ),
    );
  }
}

class TrackingTimeline2 extends StatefulWidget {
  const TrackingTimeline2({Key? key}) : super(key: key);

  @override
  State<TrackingTimeline2> createState() => _TrackingTimeline2State();
}

class _TrackingTimeline2State extends State<TrackingTimeline2> {
  bool isEdgeIndex(int index) {
    return index == 0 || index == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                thickness: 1.0,
              ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 10.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
              !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("sdrsfsd"),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
              isEdgeIndex(index) ? true : null,
          itemCount: 3,
        ),
      ),
    );
  }
}

class TrackingTimeline3 extends StatelessWidget {
  const TrackingTimeline3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        color: Color(0xfffe9e28),
        nodePosition: 0,
        // connectorTheme: ConnectorThemeData(thickness: 2),
        indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
              size: 10.0,
              position: 0.5,
            ),
      ),
      builder: TimelineTileBuilder.connectedFromStyle(
        connectionDirection: ConnectionDirection.after,
        connectorStyleBuilder: (context, index) {
          return ConnectorStyle.dashedLine;
        },
        contentsBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('Timeline Event $index'),
        ),
        indicatorStyleBuilder: (context, index) => IndicatorStyle.dot,
        itemExtent: 80.0,
        itemCount: 10,
      ),
    );
  }
}
