
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/global/global_data.dart';
import 'package:shopfee/core/service/push_noticication_service.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/simple_bloc_observer.dart';
import 'package:shopfee/features/app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /// Init system
  await initSystem();
  await Firebase.initializeApp();
  await FlutterConfig.loadEnvVariables();
  await SharedService.init();
  await ServiceLocator().init();
  await SharedService.initAppDocPath();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  await initGlobalData();
  await PushNotificationService.setUpPushNotification();
  Bloc.observer = SimpleBlocObserver();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('vi')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: const MyApp()));
}

Future<void> initGlobalData() async {
  await GlobalData.ins.createCustomIcon();
  if (GlobalData.ins.currentPosition != null) {
    await GlobalData.ins.getCurrentPosition();
  }
}

Future<void> initSystem() async {
  /// Set Device orientation to portrait up
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  // /// Hide Status bar + Navigation bar
  // await SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.immersive,
  // );
  //
  // /// Set callback to restore System UI when Status bar or Navigation bar showing
  // await SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
  //   if (systemOverlaysAreVisible) {
  //     await Future.delayed(const Duration(seconds: 3));
  //     SystemChrome.restoreSystemUIOverlays();
  //   }
  // });
}
