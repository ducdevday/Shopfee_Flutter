import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/app/config/routes.dart';
import 'package:shopfee/app/config/theme.dart';
import 'package:shopfee/app/utils/SimpleBlocObserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) {
        return AppRouter.onGenerateRoute(settings);
      },
      initialRoute: "/home",
    );
  }
}