import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopfee/app/common/data/global_data.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/theme.dart';
import 'package:shopfee/app/features/account/bloc/account_bloc.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';
import 'package:shopfee/app/features/register/cubit/register_cubit.dart';
import 'package:shopfee/app/features/welcome/cubit/welcome_cubit.dart';
import 'package:shopfee/app/utils/SimpleBlocObserver.dart';
import 'package:shopfee/data/models/address.dart';
import 'package:shopfee/data/repositories/address/address_repository.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/category/category_repository.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_repository.dart';
import 'package:shopfee/data/repositories/order/order_repository.dart';
import 'package:shopfee/data/repositories/place/place_repository.dart';
import 'package:shopfee/data/repositories/product/product_repository.dart';
import 'package:shopfee/data/repositories/user/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  _initData();
  runApp(const MyApp());
}

void _initData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  GlobalData.ins.isFirstTime = prefs.getBool('isFirstTime') ?? true;
  GlobalData.ins.userId = prefs.getString('userId');
  GlobalData.ins.accessToken = prefs.getString('accessToken');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => UserRepository()),
        RepositoryProvider(create: (_) => CategoryRepository()),
        RepositoryProvider(create: (_) => ProductRepository()),
        RepositoryProvider(create: (_) => AddressRepository()),
        RepositoryProvider(create: (_) => PlaceRepository()),
        RepositoryProvider(create: (_) => OrderRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CartBloc(orderRepository: context.read<OrderRepository>(), addressRepository: context.read<AddressRepository>())..add(LoadCart())),
          BlocProvider(
              create: (context) =>
                  AccountBloc(userRepository: context.read<UserRepository>())
                    ..add(LoadAccount()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          onGenerateRoute: (settings) {
            return AppRouter.onGenerateRoute(settings);
          },
          initialRoute: "/splash",
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
