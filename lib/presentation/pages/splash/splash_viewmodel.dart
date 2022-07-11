import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/lottie/lottie_cache.dart';
import 'package:stipra/shared/app_images.dart';
import '../../../core/platform/app_info.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../data/models/user_model.dart';
import '../../../injection_container.dart';
import '../board/board_screen.dart';
import '../home/home_page.dart';
import '../sign/enter_phone_number_page/enter_phone_number_page.dart';
import '../tabbar_view_container.dart';

import '../../../domain/repositories/local_data_repository.dart';

/// SplashViewModel is used for controlling the splash screen
/// Also the SplashPage is only appears on first time app openings to load
/// some important datas before app opens.

class SplashViewModel extends BaseViewModel {
  /// Get the version information from the app
  /// Control if the apps opening first time or not
  /// Also control if logged in or not from local database
  Future<void> loadApp(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    AppInfo.version = packageInfo.version;
    AppInfo.buildNumber = packageInfo.buildNumber;

    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    AppInfo.mobileInfo = deviceInfo.toMap();

    await exitIfNotKeepLogged();

    locator<LottieCache>().add(AppImages.searchNotFound.lottiePath);

    //await Future.delayed(Duration(milliseconds: 250));
    final isFirstLogin =
        await locator<LocalDataRepository>().isFirstTimeLogin();
    AppNavigator.pushReplacement(
      context: context,
      child: isFirstLogin ? BoardScreen() : TabBarViewContainer(),
    );
  }

  /// Get user from local database if keep logged selected login with registered data
  /// If keep logged not selected remove old data and logout
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
