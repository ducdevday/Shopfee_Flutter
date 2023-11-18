import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/cubit/my_bottom_navigation_bar_cubit.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/cubit/my_bottom_navigation_bar_cubit.dart';
import 'package:shopfee/app/common/widgets/my_bottom_navigation_bar/my_bottom_navigationbar.dart';
import 'package:shopfee/app/features/account/screen/account_screen.dart';
import 'package:shopfee/app/features/history/screen/history_screen.dart';
import 'package:shopfee/app/features/home/screen/home_screen.dart';

class DefaultScreen extends StatelessWidget {
  static const myBottomNavigationBar = MyBottomNavigationBar();

  const DefaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBottomNavigationBarCubit, MyBottomNavigationBarState>(
      builder: (context, state) {
        if(state is MyBottomNavigationBarLoaded){
          return IndexedStack(index: state.selectedIndex,
          children: const [
            HomeScreen(myBottomNavigationBar),
            HistoryScreen(myBottomNavigationBar),
            AccountScreen(myBottomNavigationBar),
          ],);
        }
        return SizedBox();
      },
    );
  }
}
