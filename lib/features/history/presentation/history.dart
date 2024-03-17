library history;

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/core/common/enum/history_status.dart';
import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/core/common/widgets/my_skeleton_rectangle.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/data/models/order_group_model.dart';
import 'package:shopfee/features/history/domain/entities/order_history_entity.dart';
import 'package:shopfee/features/history/domain/entities/order_history_group_entity.dart';
import 'package:shopfee/features/history/domain/entities/order_history_params_entity.dart';
import 'package:shopfee/features/history/domain/usecase/history_usecase.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/receipt/presentation/receipt.dart';

part 'bloc/history_bloc.dart';
part 'bloc/history_event.dart';
part 'bloc/history_state.dart';
part 'page/history_page.dart';
part 'widgets/history_filter.dart';
part 'widgets/history_item.dart';
part 'widgets/history_not_auth.dart';
part 'widgets/history_skeleton.dart';

