import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_routes.dart';
import 'package:stipra/presentation/pages/board/board_without_nothing.dart';

class SplashViewModel extends BaseViewModel {
  Future<void> loadApp(BuildContext context) async {
    await Future.delayed(Duration(microseconds: 100));
    AppNavigator.pushReplacement(
      context: context,
      child: BoardWithoutNothing(),
    );
    /*AppNavigator.pushReplacementNamed(
      context: context,
      routeName: AppRoutes.board,
    );*/
  }
}
