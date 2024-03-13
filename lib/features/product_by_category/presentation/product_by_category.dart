library product_by_category;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/core/common/enum/product_view_type.dart';
import 'package:shopfee/core/common/widgets/my_skeleton_circle.dart';
import 'package:shopfee/core/common/widgets/my_skeleton_rectangle.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/product_by_category/domain/usecase/product_by_category_usecase.dart';
import 'package:shopfee/features/search/presentation/search.dart';

part 'bloc/product_by_category_bloc.dart';
part 'bloc/product_by_category_event.dart';
part 'bloc/product_by_category_state.dart';
part 'page/product_by_category_page.dart';
part 'widgets/product_by_category_bottom.dart';
part 'widgets/product_item_skeleton.dart';
part 'widgets/product_list_skeleton.dart';
