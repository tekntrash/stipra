import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/platform/app_info.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/board/board_screen.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';

import '../../../domain/repositories/local_data_repository.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> loadApp(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    AppInfo.version = packageInfo.version;
    AppInfo.buildNumber = packageInfo.buildNumber;

    await exitIfNotKeepLogged();

    await Future.delayed(Duration(milliseconds: 250));
    AppNavigator.pushReplacement(
      context: context,
      child: TabBarViewContainer(),
    );
  }

  exitIfNotKeepLogged() async {
    var user = locator<LocalDataRepository>().getUser();
    if (user.stayLoggedIn == true) {
      return;
    } else {
      await locator<LocalDataRepository>().getUser().delete();
      await locator<LocalDataRepository>()
          .cacheUser(UserModel(stayLoggedIn: false));
    }
  }
}
