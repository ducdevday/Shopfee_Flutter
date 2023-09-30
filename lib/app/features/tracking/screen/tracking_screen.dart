import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';
import 'package:timelines/timelines.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> tracks = [
      {
        "title": "Your order was success. Wait for the coffee shop to accept",
        "time": "8:00 AM 17/08/2023",
      },
      {
        "title": "Coffee shop took your order. Wait for the coffee shop to do",
        "time": "8:15 AM 17/08/2023",
      },
      {
        "title": "Your order is ready. Shipper is on its way to you",
        "time": "8:30 AM 17/08/2023",
      },
      {
        "title": "You take your order",
        "time": "8:45 AM 17/08/2023",
      },
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text("Tracking"),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimen.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                SvgPicture.asset(
                  "assets/icons/ic_delivery.svg",
                  width: 70,
                  height: 70,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Coffee milk",
                        style: AppStyle.mediumTextStyleDark
                            .copyWith(color: AppColor.headingColor, height: 2),
                      ),
                      Text(
                        "12:30 - 30/9/2023",
                        style: AppStyle.normalTextStyleDark,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "25,000đ",
                      style: AppStyle.mediumTextStyleDark
                          .copyWith(color: AppColor.headingColor, height: 2),
                    ),
                    SvgPicture.asset("assets/icons/ic_pending.svg")
                  ],
                )
              ]),
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.keyboard_arrow_right_rounded),
                    label: Text(
                      "Receipt",
                      style: AppStyle.normalTextStylePrimary
                          .copyWith(fontWeight: FontWeight.w500),
                    )),
              ),
              Divider(
                height: 10,
              ),
              Padding(
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
              ),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Cancel Order"),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                            backgroundColor: AppColor.error,
                            disabledBackgroundColor: const Color(0xffCACACA),
                            disabledForegroundColor: AppColor.lightColor,
                            textStyle: AppStyle.mediumTextStyleDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            )),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}

class TrackingTimeline extends StatefulWidget {
  const TrackingTimeline({Key? key}) : super(key: key);

  @override
  State<TrackingTimeline> createState() => _TrackingTimelineState();
}

class _TrackingTimelineState extends State<TrackingTimeline> {
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

class TempTrackingTimeline extends StatelessWidget {
  const TempTrackingTimeline({Key? key}) : super(key: key);

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
