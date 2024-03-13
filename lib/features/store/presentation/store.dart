library store;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopfee/core/common/enum/product_view_type.dart';
import 'package:shopfee/core/common/enum/store_view_type.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/common/widgets/my_skeleton_rectangle.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/global/global_data.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/core/utils/permission_util.dart';
import 'package:shopfee/features/store/domain/entities/store_all_params_entity.dart';
import 'package:shopfee/features/store/domain/entities/store_information_entity.dart';
import 'package:shopfee/features/store/domain/usecase/store_usecase.dart';
import 'package:shopfee/features/store_detail/presentation/store_detail.dart';

part 'bloc/store_bloc.dart';
part 'bloc/store_event.dart';
part 'bloc/store_state.dart';
part 'page/store_page.dart';
part 'widgets/store_item.dart';
part 'widgets/store_skeleton.dart';
part 'widgets/store_list_view.dart';
part 'widgets/store_map_view.dart';
