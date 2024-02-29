library personal_information;

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/common/enum/field_type.dart';
import 'package:shopfee/core/common/models/gender.dart';
import 'package:shopfee/core/common/widgets/email_input_field.dart';
import 'package:shopfee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/core/common/widgets/name_input_field.dart';
import 'package:shopfee/core/common/widgets/phone_input_field.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/di/service_locator.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/core/utils/format_util.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/core/utils/validate_field_util.dart';
import 'package:shopfee/features/personal_information/domain/usecase/personal_information_usecase.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';
import 'package:shopfee/features/user/presentation/user.dart';
import 'package:image_picker/image_picker.dart';

part 'cubit/personal_information_cubit.dart';
part 'cubit/personal_information_state.dart';
part 'page/personal_information_page.dart';