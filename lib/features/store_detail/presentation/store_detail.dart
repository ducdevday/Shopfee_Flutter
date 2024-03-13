library store_detail;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopfee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/core/common/widgets/my_error_page.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/alert_util.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';
import 'package:shopfee/features/store_detail/domain/entities/store_detail_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/order/presentation/order.dart';
import 'package:shopfee/features/store_detail/domain/usecase/store_detail_usecase.dart';
import 'package:url_launcher/url_launcher.dart';

part 'bloc/store_detail_bloc.dart';
part 'bloc/store_detail_event.dart';
part 'bloc/store_detail_state.dart';
part 'page/store_detail_page.dart';
part 'page/store_detail_loading_page.dart';

