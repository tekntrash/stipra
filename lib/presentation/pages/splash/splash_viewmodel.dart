import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/platform/app_info.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/board/board_screen.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> loadApp(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    AppInfo.version = packageInfo.version;
    AppInfo.buildNumber = packageInfo.buildNumber;
    await Future.delayed(Duration(milliseconds: 250));
    AppNavigator.pushReplacement(
      context: context,
      child: TabBarViewContainer(),
    );
  }
}
