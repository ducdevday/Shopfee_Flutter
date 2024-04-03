library login;

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/widgets/email_input_field.dart';
import 'package:shopfee/core/common/widgets/password_input_field.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/global_keys.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/forgot_password/presentation/forgot_password.dart';
import 'package:shopfee/features/login/domain/entities/login_entity.dart';
import 'package:shopfee/features/login/domain/usecase/login_usecase.dart';
import 'package:shopfee/features/register/presentation/register.dart';

part 'cubit/login_cubit.dart';
part 'cubit/login_state.dart';
part 'page/login_page.dart';