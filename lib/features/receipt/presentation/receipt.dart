library receipt;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/common/enum/payment_status.dart';
import 'package:shopfee/core/common/enum/payment_type.dart';
import 'package:shopfee/core/common/enum/reason_cancel_type.dart';
import 'package:shopfee/core/common/enum/refund_request_status.dart';
import 'package:shopfee/core/common/extensions/actor_type_extension.dart';
import 'package:shopfee/core/common/extensions/order_status_extension.dart';
import 'package:shopfee/core/common/extensions/payment_status_extension.dart';
import 'package:shopfee/core/common/extensions/payment_type_extension.dart';
import 'package:shopfee/core/common/models/order_status.dart';
import 'package:shopfee/core/common/models/order_type.dart';
import 'package:shopfee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/core/common/widgets/my_error_page.dart';
import 'package:shopfee/core/common/widgets/my_label.dart';
import 'package:shopfee/core/common/widgets/my_loading_page.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/data/models/order_result.dart';
import 'package:shopfee/features/coupon_in_cart/domain/entities/product_reward_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/event_log_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_product_detail_entity.dart';
import 'package:shopfee/features/receipt/domain/entities/receipt_product_entity.dart';
import 'package:shopfee/features/receipt/domain/usecase/receipt_usecase.dart';
import 'package:shopfee/features/refund/presentation/refund.dart';
import 'package:shopfee/features/review/presentation/review.dart';
import 'package:shopfee/features/tracking/presentation/tracking.dart';
import 'package:shopfee/features/vnpay/presentation/vnpay.dart';

part 'bloc/receipt_bloc.dart';
part 'bloc/receipt_event.dart';
part 'bloc/receipt_extention.dart';
part 'bloc/receipt_state.dart';
part 'page/receipt_page.dart';
part 'widgets/bought_list.dart';
part 'widgets/gift_list.dart';
part 'widgets/cancel_button.dart';
part 'widgets/cancel_detail.dart';
part 'widgets/delivery_information.dart';
part 'widgets/last_status_widget.dart';
part 'widgets/note_receipt.dart';
part 'widgets/payment_summary.dart';
part 'widgets/reason_cancel_sheet.dart';
part 'widgets/receipt_bottom_action.dart';
part 'widgets/receipt_information.dart';
part 'widgets/receipt_status_information.dart';
part 'widgets/review_summary.dart';
part 'widgets/review_widget.dart';
part 'widgets/take_away_information.dart';
