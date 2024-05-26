library cart;

import 'dart:async';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:shopfee/core/common/enum/coupon_type.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/extensions/coupon_type_extension.dart';
import 'package:shopfee/core/common/extensions/payment_type_extension.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/core/common/widgets/my_input_dialog.dart';
import 'package:shopfee/core/common/widgets/name_input_field.dart';
import 'package:shopfee/core/common/widgets/phone_input_field.dart';
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
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/cart/data/models/cart_invalid_branch.dart';
import 'package:shopfee/features/cart/data/models/cart_model.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/cart/domain/entities/cart_entity.dart';
import 'package:shopfee/features/cart/domain/entities/cart_extension.dart';
import 'package:shopfee/features/cart/domain/entities/receiver_onsite_entity.dart';
import 'package:shopfee/features/cart/domain/usecase/cart_usecase.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_entity.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/coupon_check_result_extension.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/reward_information_extension.dart';
import 'package:shopfee/features/coupon_in_cart/presentation/coupon_in_cart.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/new_address/presentation/new_address.dart';
import 'package:shopfee/features/product_detail/domain/entities/order_entity.dart';
import 'package:shopfee/features/product_detail/presentation/product_detail.dart';
import 'package:shopfee/features/receipt/presentation/receipt.dart';
import 'package:shopfee/features/saved_address/presentation/saved_address.dart';
import 'package:shopfee/features/store/presentation/store.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';
import 'package:shopfee/features/user/presentation/user.dart';
import 'package:shopfee/features/vnpay/presentation/vnpay.dart';

part 'bloc/cart_bloc.dart';

part 'bloc/cart_event.dart';

part 'bloc/cart_state.dart';

part 'page/cart_page.dart';

part 'widgets/address_shipping_widget.dart';

part 'widgets/cart_bottom_bar.dart';

part 'widgets/product_chosen_item.dart';

part 'widgets/coin_applied_widget.dart';

part 'widgets/coupon_applied_widget.dart';

part 'widgets/delivery_bottom_sheet.dart';

part 'widgets/edit_order_bottom_sheet.dart';

part 'widgets/payment_bottom_sheet.dart';

part 'widgets/payment_method.dart';

part 'widgets/payment_summary.dart';

part 'widgets/product_chosen_list.dart';

part 'widgets/receiver_information_bottom_sheet.dart';

part 'widgets/receiver_information_widget.dart';

part 'widgets/store_widget.dart';

part 'widgets/time_open_close.dart';

part 'widgets/time_setter.dart';

part 'widgets/time_shipping.dart';

part 'widgets/product_gift_list.dart';

part 'widgets/product_gift_item.dart';

part 'widgets/cart_item_container_widget.dart';

part 'widgets/branch_conflict_bottom_sheet.dart';
