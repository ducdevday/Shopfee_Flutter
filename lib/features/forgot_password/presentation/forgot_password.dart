library forgot_password;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/widgets/email_input_field.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/forgot_password/domain/usecase/forgot_password_usecase.dart';
import 'package:shopfee/features/otp/presentation/otp.dart';

part 'cubit/forgot_password_cubit.dart';
part 'cubit/forgot_password_state.dart';
part 'page/forgot_password_page.dart';
