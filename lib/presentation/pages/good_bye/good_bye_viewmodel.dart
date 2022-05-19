import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';

class GoodByeViewModel extends BaseViewModel {
  goToHomePage(BuildContext context) {
    AppNavigator.pushReplacement(
      context: context,
      child: TabBarViewContainer(),
    );
  }
}
