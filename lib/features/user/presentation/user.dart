library user;

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shopfee/core/service/shared_service.dart';
import 'package:shopfee/core/utils/exception_util.dart';
import 'package:shopfee/features/user/domain/entities/user_entity.dart';
import 'package:shopfee/features/user/domain/usecase/user_usecase.dart';


part 'bloc/user_bloc.dart';
part 'bloc/user_event.dart';
part 'bloc/user_state.dart';