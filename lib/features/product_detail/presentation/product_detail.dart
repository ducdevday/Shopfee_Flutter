library product_detail;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';
import 'package:shopfee/features/product_detail/domain/usecase/product_detail_usecase.dart';

part 'bloc/product_detail_bloc.dart';

part 'bloc/product_detail_event.dart';

part 'bloc/product_detail_state.dart';

part 'widgets/note_opt.dart';

part 'widgets/product_bottom_bar.dart';

part 'widgets/product_quantity.dart';

part 'widgets/size_filter.dart';

part 'widgets/topping_filter.dart';
