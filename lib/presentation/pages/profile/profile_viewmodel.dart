import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../board/board_screen.dart';
import '../change_email/change_email_page.dart';
import '../edit_profile_page/edit_profile_page.dart';
import '../sign/change_password/change_password_page.dart';

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

  routeToChangeEmail(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: ChangeEmailPage(),
    );
  }

  routeToEditProfile(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: EditProfilePage(),
    );
  }

  logout(BuildContext context) {
    locator<LocalDataRepository>().getUser().alogin = null;
    locator<LocalDataRepository>().getUser().userid = null;
    locator<LocalDataRepository>().getUser().name = null;
    notifyListeners();
  }
}
