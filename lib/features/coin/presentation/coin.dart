library coin;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopfee/core/common/widgets/my_empty_list.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/coin/data/models/coin_history_params.dart';
import 'package:shopfee/features/coin/domain/entities/coin_history_entity.dart';
import 'package:shopfee/features/coin/domain/usecase/coin_usecase.dart';

part 'bloc/coin_bloc.dart';
part 'bloc/coin_event.dart';
part 'bloc/coin_state.dart';
part 'page/coin_page.dart';
part 'widgets/coin_history_item.dart';