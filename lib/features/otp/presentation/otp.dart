library otp;

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/features/change_password/presentation/change_password.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/forgot_password/presentation/forgot_password.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/otp/domain/usecase/otp_usecase.dart';
import 'package:shopfee/features/register/domain/entities/register_entity.dart';
import 'package:shopfee/features/register/presentation/register.dart';


part 'cubit/otp_cubit.dart';
part 'cubit/otp_state.dart';
part 'page/otp_page.dart';
part 'widgets/otp_box.dart';
