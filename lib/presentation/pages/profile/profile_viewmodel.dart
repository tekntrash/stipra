import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/delete_account/delete_account_page.dart';
import 'package:stipra/presentation/pages/my_products/my_products_page.dart';
import 'package:stipra/presentation/pages/my_trades/my_trades_page.dart';
import 'package:stipra/presentation/pages/videos_waiting/videos_waiting_page.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../change_email/change_email_page.dart';
import '../edit_profile_page/edit_profile_page.dart';
import '../sign/change_password/change_password_page.dart';

/// Profile Controller for handling routes in there
/// Also handles the buttons from here

class ProfileViewModel extends BaseViewModel {
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

  routeToMyTrades(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: MyTradesPage(),
    );
  }

  routeToVideosWaiting(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: VideosWaitingPage(),
    );
  }

  routeToProductsConsumed(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: MyProductsPage(),
    );
  }

  routeToDeleteAccount(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: DeleteAccountPage(),
    );
  }

  logout(BuildContext context) {
    locator<LocalDataRepository>().getUser().alogin = null;
    locator<LocalDataRepository>().getUser().userid = null;
    locator<LocalDataRepository>().getUser().name = null;
    locator<LocalDataRepository>().getUser().save();
    notifyListeners();
  }
}
