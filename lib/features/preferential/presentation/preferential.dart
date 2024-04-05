library preferential;

import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/common/extensions/coupon_type_extension.dart';
import 'package:shopfee/core/common/widgets/my_empty_list.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/common/widgets/my_shimmer_rectangle.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/router/app_router.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/coupon/presentation/coupon.dart';
import 'package:shopfee/features/coupon_detail/presentation/coupon_detail.dart';
import 'package:shopfee/features/coupon_in_cart/presentation/coupon_in_cart.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/preferential/domain/entities/coupon_by_type_entity.dart';
import 'package:shopfee/features/preferential/domain/usecase/preferential_usecase.dart';
import 'package:shopfee/features/user/presentation/user.dart';

part 'bloc/preferential_bloc.dart';

part 'bloc/preferential_event.dart';

part 'bloc/preferential_state.dart';

part 'page/preferential_page.dart';

part 'widgets/coupon_by_type_item.dart';

part 'widgets/coupon_by_type_list.dart';

part 'widgets/coupon_by_type_skeleton.dart';

part 'widgets/coupon_skeleton_list.dart';
