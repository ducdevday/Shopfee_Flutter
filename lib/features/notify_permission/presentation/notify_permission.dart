library notify_permission;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/push_noticication_service.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/alert_util.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/notify_permission/domain/usecase/notification_permission_usecase.dart';

part 'cubit/notification_permission_cubit.dart';
part 'cubit/notification_permission_state.dart';
part 'page/notify_permission_page.dart';