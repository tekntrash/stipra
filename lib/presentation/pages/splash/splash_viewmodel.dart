import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/board/board_screen.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> loadApp(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 250));
    AppNavigator.pushReplacement(
      context: context,
      child: TabBarViewContainer(),
    );
  }
}
