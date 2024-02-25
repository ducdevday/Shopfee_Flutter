library choose_address;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/choose_address/domain/entities/district_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/provice_entity.dart';
import 'package:shopfee/features/choose_address/domain/entities/ward_entity.dart';
import 'package:shopfee/features/choose_address/domain/usecase/choose_address_usecase.dart';
import 'package:shopfee/features/google_map/data/models/geo_result_model.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/presentation/page/google_map_page.dart';

part 'bloc/choose_address_bloc.dart';
part 'bloc/choose_address_event.dart';
part 'bloc/choose_address_state.dart';
part 'page/choose_address_page.dart';
