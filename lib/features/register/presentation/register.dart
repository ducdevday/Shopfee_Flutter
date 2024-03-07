library register;

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/widgets/email_input_field.dart';
import 'package:shopfee/core/common/widgets/name_input_field.dart';
import 'package:shopfee/core/common/widgets/password_input_field.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/otp/presentation/otp.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';
import 'package:shopfee/features/register/domain/usecase/register_usecase.dart';

part 'cubit/register_cubit.dart';
part 'cubit/register_state.dart';
part 'page/register_page.dart';

