import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import '../../../core/platform/app_info.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../data/models/user_model.dart';
import '../../../injection_container.dart';
import '../board/board_screen.dart';
import '../home/home_page.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';
import '../tabbar_view_container.dart';

import '../../../domain/repositories/local_data_repository.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> loadApp(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    AppInfo.version = packageInfo.version;
    AppInfo.buildNumber = packageInfo.buildNumber;

    await exitIfNotKeepLogged();

    //await Future.delayed(Duration(milliseconds: 250));
    final isFirstLogin =
        await locator<LocalDataRepository>().isFirstTimeLogin();
    AppNavigator.pushReplacement(
      context: context,
      child: isFirstLogin ? BoardScreen() : TabBarViewContainer(),
    );
  }

  exitIfNotKeepLogged() async {
    var user = locator<LocalDataRepository>().getUser();
    if (user.stayLoggedIn == true) {
      return;
    } else {
      final DateTime? lastLogged = user.lastLoginTime;
      await locator<LocalDataRepository>().getUser().delete();
      await locator<LocalDataRepository>().cacheUser(
        UserModel(
          stayLoggedIn: false,
          lastLoginTime: lastLogged,
        ),
      );
    }
  }
}
