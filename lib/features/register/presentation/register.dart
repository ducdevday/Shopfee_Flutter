library register;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/widgets/email_input_field.dart';
import 'package:shopfee/core/common/widgets/name_input_field.dart';
import 'package:shopfee/core/common/widgets/password_input_field.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/otp/presentation/otp.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';
import 'package:shopfee/features/register/presentation/cubit/register_cubit.dart';

part 'page/register_page.dart';

