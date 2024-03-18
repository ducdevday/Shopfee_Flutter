library cart;

import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shopfee/core/common/enum/delivery_type.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/errors/app_exception.dart';
import 'package:shopfee/core/global/global_data.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/alert_util.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/core/utils/permission_util.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/entities/cart_extension.dart';
import 'package:shopfee/features/cart/domain/usecase/cart_usecase.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/new_address/presentation/new_address.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:shopfee/features/receipt/presentation/receipt.dart';
import 'package:shopfee/features/saved_address/presentation/saved_address.dart';
import 'package:shopfee/features/store/presentation/store.dart';
import 'package:shopfee/features/user/presentation/user.dart';
import 'package:shopfee/features/vnpay/presentation/vnpay.dart';
import 'package:collection/collection.dart';
part 'bloc/cart_bloc.dart';

part 'bloc/cart_event.dart';

part 'bloc/cart_state.dart';

part 'page/cart_page.dart';

part 'widgets/address_shipping_widget.dart';

part 'widgets/store_widget.dart';

part 'widgets/time_open_close.dart';

part 'widgets/cart_item.dart';

part 'widgets/delivery_bottom_sheet.dart';

part 'widgets/edit_order_bottom_sheet.dart';

part 'widgets/payment_bottom_sheet.dart';

part 'widgets/product_list.dart';

part 'widgets/time_shipping.dart';

part 'widgets/time_setter.dart';

part 'widgets/payment_method.dart';

part 'widgets/payment_summary.dart';

part 'widgets/coupon_applied_widget.dart';

part 'widgets/coin_applied_widget.dart';
