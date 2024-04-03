import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/common/widgets/my_error_page.dart';
import 'package:shopfee/core/common/widgets/my_loading_page.dart';
import 'package:shopfee/features/account/presentation/account.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/order/presentation/order.dart';
import 'package:shopfee/features/preferential/presentation/preferential.dart';
import 'package:shopfee/features/store/presentation/store.dart';
import 'package:shopfee/features/user/presentation/user.dart';

class DefaultPage extends StatefulWidget {
  static const String route = '/';

  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final List<Widget> pages = const [
    HomePage(),
    OrderPage(),
    StorePage(),
    PreferentialPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserLoadInformation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadInProcess) {
          return const MyLoadingPage();
        } else if (state is UserInitial || state is UserLoadSuccess) {
          return BlocBuilder<MyBottomNavBarCubit, int>(
            builder: (context, selectedPage) {
              return Scaffold(
                // body: IndexedStack(index: selectedPage, children: pages),
                body: pages[selectedPage],
                bottomNavigationBar: const MyBottomNavBar(),
              );
            },
          );
        } else if (state is UserLoadFailure) {
          return const MyErrorPage();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
