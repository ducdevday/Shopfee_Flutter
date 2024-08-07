library home;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shopfee/core/common/enum/product_status.dart';
import 'package:shopfee/core/common/enum/product_view_type.dart';
import 'package:shopfee/core/common/widgets/my_error_page.dart';
import 'package:shopfee/core/common/widgets/my_placeholder_rectangle.dart';
import 'package:shopfee/core/common/widgets/my_shimmer_circle.dart';
import 'package:shopfee/core/common/widgets/my_shimmer_rectangle.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopfee/core/global/r.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/blog/domain/entities/blog_information_entity.dart';
import 'package:shopfee/features/blog/presentation/blog.dart';
import 'package:shopfee/features/blog_detail/presentation/blog_detail.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/home/domain/entities/banner_entity.dart';
import 'package:shopfee/features/home/domain/entities/category_entity.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/domain/usecase/home_usecase.dart';
import 'package:shopfee/features/product_by_category/presentation/product_by_category.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';
import 'package:shopfee/features/search/presentation/search.dart';
import 'widgets/home_float_action.dart';


part 'bloc/home_bloc.dart';
part 'bloc/home_event.dart';
part 'bloc/home_state.dart';
part 'page/home_page.dart';
part 'widgets/home_skeleton.dart';
part 'widgets/home_slider.dart';
part 'widgets/home_product.dart';
part 'widgets/home_blog.dart';