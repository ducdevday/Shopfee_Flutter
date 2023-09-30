import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/config/color.dart';
import 'package:shopfee/app/config/dimens.dart';
import 'package:shopfee/app/config/style.dart';

enum Status { Processing, Done, Canceled }

class HistoryScreen extends StatelessWidget {
  final MyBottomNavigationBar myBottomNavigationBar;

  const HistoryScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimen.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HistoryFilter(),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(children: [
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
                                style: AppStyle.mediumTextStyleDark.copyWith(color: AppColor.headingColor, height: 2),
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
                              style: AppStyle.mediumTextStyleDark.copyWith(color: AppColor.headingColor,height: 2),
                            ),
                            SvgPicture.asset("assets/icons/ic_pending.svg")
                          ],
                        )
                      ]),
                  separatorBuilder: (context, index) => Divider(
                        height: 10,
                      ),
                  itemCount: 3)
            ],
          ),
        ),
      ),
      bottomNavigationBar: myBottomNavigationBar,
    );
  }
}

class HistoryFilter extends StatefulWidget {
  const HistoryFilter({Key? key}) : super(key: key);

  @override
  State<HistoryFilter> createState() => _HistoryFilterState();
}

class _HistoryFilterState extends State<HistoryFilter> {
  Status _status = Status.Processing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterChip(
            labelPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            showCheckmark: false,
            selectedColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            label: Text(
              Status.Processing.name,
              style: AppStyle.smallTextStyleDark.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _status == Status.Processing
                      ? Colors.white
                      : AppColor.headingColor),
            ),
            selected: _status == Status.Processing,
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  _status = Status.Processing;
                });
              }
            }),
        SizedBox(width: 8),
        FilterChip(
            labelPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            showCheckmark: false,
            selectedColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            label: Text(
              Status.Done.name,
              style: AppStyle.smallTextStyleDark.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _status == Status.Done
                      ? Colors.white
                      : AppColor.headingColor),
            ),
            selected: _status == Status.Done,
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  _status = Status.Done;
                });
              }
            }),
        SizedBox(width: 8),
        FilterChip(
            labelPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            showCheckmark: false,
            selectedColor: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            label: Text(
              Status.Canceled.name,
              style: AppStyle.smallTextStyleDark.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _status == Status.Canceled
                      ? Colors.white
                      : AppColor.headingColor),
            ),
            selected: _status == Status.Canceled,
            onSelected: (bool selected) {
              if (selected) {
                setState(() {
                  _status = Status.Canceled;
                });
              }
            }),
      ],
    );
  }
}
