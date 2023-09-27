import 'package:flutter/material.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigationbar.dart';
import 'package:shopfee/app/config/dimens.dart';

class HistoryScreen extends StatelessWidget {
  final MyBottomNavigationBar myBottomNavigationBar;
  const HistoryScreen(this.myBottomNavigationBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppDimen.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        ),
      ),
      bottomNavigationBar: myBottomNavigationBar,
    );
  }
}
