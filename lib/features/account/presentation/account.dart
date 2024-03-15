library account;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopfee/core/common/widgets/my_confirm_dialog.dart';
import 'package:shopfee/core/config/app_color.dart';
import 'package:shopfee/core/config/app_dimen.dart';
import 'package:shopfee/core/config/app_path.dart';
import 'package:shopfee/core/config/app_style.dart';
import 'package:shopfee/core/utils/navigation_util.dart';
import 'package:shopfee/features/cart/presentation/cart.dart';
import 'package:shopfee/features/default/presentation/page/default_page.dart';
import 'package:shopfee/features/default/presentation/widgets/bottombar/my_bottom_nav_bar_cubit.dart';
import 'package:shopfee/features/history/presentation/history.dart';
import 'package:shopfee/features/home/presentation/home.dart';
import 'package:shopfee/features/login/presentation/login.dart';
import 'package:shopfee/features/new_password/presentation/new_password.dart';
import 'package:shopfee/features/personal_information/presentation/personal_information.dart';
import 'package:shopfee/features/user/presentation/user.dart';
import 'package:shopfee/features/saved_address/presentation/saved_address.dart';

part 'page/account_page.dart';
part 'widgets/menu_item.dart';
