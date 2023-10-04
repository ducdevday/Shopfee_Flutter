import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/theme.dart';
import 'package:shopfee/app/features/cart/bloc/cart_bloc.dart';
import 'package:shopfee/app/features/geolocation/bloc/geolocation_bloc.dart';
import 'package:shopfee/app/features/register/cubit/register_cubit.dart';
import 'package:shopfee/app/features/welcome/cubit/welcome_cubit.dart';
import 'package:shopfee/app/utils/SimpleBlocObserver.dart';
import 'package:shopfee/data/repositories/auth/auth_repository.dart';
import 'package:shopfee/data/repositories/geolocation/geolocation_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
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
        RepositoryProvider(create: (_) => AuthRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GeolocationBloc(
              geolocationRepository: context.read<GeolocationRepository>())..add(LoadGeolocation())),
          BlocProvider(create: (context) => WelcomeCubit(authRepository: context.read<AuthRepository>())..initCubit()),
          BlocProvider(create: (context) =>
          CartBloc()
            ..add(LoadCart()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          onGenerateRoute: (settings) {
            return AppRouter.onGenerateRoute(settings);
          },
          initialRoute: "/welcome",
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
