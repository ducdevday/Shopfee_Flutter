library saved_address;

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/common/widgets/my_alert_dialog.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/choose_address/presentation/choose_address.dart';
import 'package:shopfee/features/new_address/presentation/new_address.dart';
import 'package:shopfee/features/saved_address/domain/entities/address_entity.dart';
import 'package:shopfee/features/saved_address/domain/usecase/saved_address_usecase.dart';

part 'bloc/saved_address_bloc.dart';

part 'bloc/saved_address_event.dart';

part 'bloc/saved_address_state.dart';

part 'page/saved_address_page.dart';
