library product_detail;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:overlay_tooltip/overlay_tooltip.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopfee/core/common/enum/product_status.dart';
import 'package:shopfee/core/common/enum/product_view_type.dart';
import 'package:shopfee/core/common/widgets/my_container.dart';
import 'package:shopfee/core/common/widgets/network_img_full_screen.dart';
import 'package:shopfee/core/common/widgets/my_error_page.dart';
import 'package:shopfee/core/common/widgets/my_loading_page.dart';
import 'package:shopfee/core/common/widgets/my_placeholder_rectangle.dart';
import 'package:shopfee/core/common/widgets/my_shimmer_rectangle.dart';
import 'package:shopfee/core/common/widgets/my_tooltip.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/global/r.dart';
import 'package:shopfee/core/log/event_log.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/home/domain/entities/product_infomation_entity.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/size_entity.dart';
import 'package:shopfee/features/product_detail/domain/entities/topping_entity.dart';
import 'package:shopfee/features/product_detail/domain/usecase/product_detail_usecase.dart';
import 'package:shopfee/features/review_detail/domain/entities/review_detail_arguments.dart';
import 'package:shopfee/features/review_detail/presentation/review_detail.dart';

part 'bloc/product_detail_bloc.dart';
part 'bloc/product_detail_event.dart';
part 'bloc/product_detail_state.dart';
part 'page/product_detail_page.dart';
part 'widgets/product_image.dart';
part 'widgets/note_opt.dart';
part 'widgets/product_bottom_bar.dart';
part 'widgets/product_quantity.dart';
part 'widgets/size_filter.dart';
part 'widgets/topping_filter.dart';
part 'widgets/recommend_product_list.dart';
