library review;

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/widgets/my_container.dart';
import 'package:shopfee/core/common/widgets/my_error_widget.dart';
import 'package:shopfee/core/common/widgets/my_placeholder_rectangle.dart';
import 'package:shopfee/core/common/widgets/my_star_list.dart';
import 'package:shopfee/core/common/widgets/text_input_field.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/review/domain/entities/review_information_entity.dart';
import 'package:shopfee/features/review/domain/entities/review_params.dart';
import 'package:shopfee/features/review/domain/usecase/review_usecase.dart';

part 'bloc/review_bloc.dart';
part 'bloc/review_event.dart';
part 'bloc/review_state.dart';
part 'page/review_page.dart';
part 'widgets/review_dialog.dart';
part 'widgets/review_information_list.dart';
