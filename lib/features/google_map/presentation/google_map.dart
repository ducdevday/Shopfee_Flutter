library google_map;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/controller/debounce_controller.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/global/r.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/google_map/domain/entities/auto_complete_result_entity.dart';
import 'package:shopfee/features/google_map/domain/entities/geo_result_entity.dart';
import 'package:shopfee/features/google_map/domain/usecase/google_map_usecase.dart';

part 'bloc/google_map_bloc.dart';
part 'bloc/google_map_event.dart';
part 'bloc/google_map_state.dart';
part 'page/google_map_page.dart';
part 'widgets/google_map_list_place.dart';
part 'widgets/google_map_loading_widget.dart';
part 'widgets/google_map_widget.dart';
