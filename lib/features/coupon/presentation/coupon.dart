library coupon;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/common/widgets/my_empty_list.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/features/coupon/domain/usecase/coupon_usecase.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';
import 'package:shopfee/features/preferential/presentation/preferential.dart';
import 'package:timelines/timelines.dart';
import 'package:badges/badges.dart' as badges;
import 'package:collection/collection.dart';

part 'bloc/coupon_bloc.dart';

part 'bloc/coupon_event.dart';

part 'bloc/coupon_state.dart';

part 'page/coupon_page.dart';

part 'widgets/coupon_by_type_tabview.dart';
