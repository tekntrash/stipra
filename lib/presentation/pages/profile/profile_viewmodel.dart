import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/board/board_screen.dart';
import 'package:stipra/presentation/pages/sign/change_password/change_password_page.dart';

class ProfileViewModel extends BaseViewModel {
  late bool isInited;
  init() async {
    isInited = false;
    await Future.wait([
      /*requestPermisisons(),
      getProducts(),
      getOffers(),
      informAboutUploadedVideo(),*/
    ]);
    isInited = true;
    notifyListeners();
  }

  routeToChangePassword(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: ChangePasswordPage(),
    );
  }

  logout(BuildContext context) {
    locator<LocalDataRepository>().getUser().alogin = null;
    locator<LocalDataRepository>().getUser().userid = null;
    locator<LocalDataRepository>().getUser().name = null;
    notifyListeners();
  }
}