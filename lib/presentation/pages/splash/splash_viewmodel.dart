import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_routes.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> loadApp(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    AppNavigator.pushReplacementNamed(
      context: context,
      routeName: AppRoutes.home,
    );
  }
}
