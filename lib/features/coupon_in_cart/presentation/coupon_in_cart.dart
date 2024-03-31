library coupon_in_cart;

import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/common/extensions/coupon_type_extension.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_in_cart_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_informaiton_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_information_extension.dart';
import 'package:shopfee/features/coupon_in_cart/domain/usecase/coupon_in_cart_usecase.dart';

part 'bloc/coupon_in_cart_bloc.dart';
part 'bloc/coupon_in_cart_event.dart';
part 'bloc/coupon_in_cart_state.dart';
part 'page/coupon_in_cart_page.dart';
part 'widgets/coupon_information_item.dart';
part 'widgets/coupon_information_list.dart';