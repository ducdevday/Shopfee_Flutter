library coupon_detail;


import 'package:dotted_line/dotted_line.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/core/global/r.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/coupon_detail/domain/entities/coupon_detail_entity.dart';
import 'package:shopfee/features/coupon_detail/domain/entities/coupon_detail_extention.dart';
import 'package:shopfee/features/coupon_detail/domain/usecase/coupon_detail_usecase.dart';

part 'bloc/coupon_detail_bloc.dart';
part 'bloc/coupon_detail_event.dart';
part 'bloc/coupon_detail_state.dart';
part 'page/coupon_detail_page.dart';
part 'widgets/coupon_detail_loading_widget.dart';