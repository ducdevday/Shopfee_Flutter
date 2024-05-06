library statistics;

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/common/enum/chart_type.dart';
import 'package:shopfee/core/common/enum/statistic_type.dart';
import 'package:shopfee/core/common/widgets/my_container.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/alert_util.dart';
import 'package:shopfee/core/utils/calculate_util.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/statistics/domain/entities/chart_circular_data.dart';
import 'package:shopfee/features/statistics/domain/entities/chart_line_data.dart';
import 'package:shopfee/features/statistics/domain/usecase/statistics_usecase.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'bloc/statistics_bloc.dart';

part 'bloc/statistics_event.dart';

part 'bloc/statistics_state.dart';

part 'widgets/chart_amount_paid.dart';

part 'widgets/chart_total_order.dart';

part 'widgets/chart_tracking.dart';

part 'page/statistics_page.dart';
