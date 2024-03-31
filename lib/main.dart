import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.getInitialMessage();
  await FlutterConfig.loadEnvVariables();
  await SharedService.init();
  await ServiceLocator().init();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  await initData();
  await PushNotificationService.setUpPushNotification();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

Future<void> initData() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  final String appDocPath = appDocDir.path;
  SharedService.setAppDocPath(appDocPath);

  await GlobalData.ins.createCustomIcon();
  if (GlobalData.ins.currentPosition != null) {
    await GlobalData.ins.getCurrentPosition();
  }
}