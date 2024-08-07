library search;


import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shopfee/core/common/enum/product_view_type.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/controller/debounce_controller.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/global/r.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/search/domain/entities/autocomplete_product_entity.dart';
import 'package:shopfee/features/search/domain/usecase/search_usecase.dart';

part 'cubit/search_cubit.dart';
part 'cubit/search_state.dart';
part 'page/search_page.dart';
