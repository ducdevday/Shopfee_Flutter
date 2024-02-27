library order;

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/presentation/widgets/home_float_action.dart';
import 'package:shopfee/features/order/domain/usecase/order_usecase.dart';
import 'package:shopfee/features/product_by_category/presentation/product_by_category.dart';
import 'package:shopfee/features/search/presentation/search.dart';

part 'bloc/order_bloc.dart';
part 'bloc/order_event.dart';
part 'bloc/order_state.dart';
part 'page/order_page.dart';