import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/data/models/privacy_model.dart';
import 'package:stipra/presentation/pages/delete_account/delete_account_page.dart';
import 'package:stipra/presentation/pages/my_products/my_products_page.dart';
import 'package:stipra/presentation/pages/my_trades/my_trades_page.dart';
import 'package:stipra/presentation/pages/videos_waiting/videos_waiting_page.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
import '../../../core/utils/router/app_navigator.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../../../injection_container.dart';
import '../change_email/change_email_page.dart';
import '../edit_profile_page/edit_profile_page.dart';
import '../sign/change_password/change_password_page.dart';

/// Profile Controller for handling routes in there
/// Also handles the buttons from here

class PrivacyViewModel extends BaseViewModel {
  late PrivacyModel privacyModel;
  bool? isInited;

  Future<void> init() async {
    isInited = false;
    privacyModel = PrivacyModel(
      receiveemailspoints: false,
      receivenewsletter: false,
      receivenotifications: false,
    );
    await getPrivacy();
    isInited = true;
    notifyListeners();
  }

  Future<void> getPrivacy() async {
    final data = await locator<DataRepository>().getPrivacy();
    if (data is Right) {
      privacyModel = (data as Right).value;
    } else {
      privacyModel = PrivacyModel(
        receiveemailspoints: false,
        receivenewsletter: false,
        receivenotifications: false,
      );
    }
  }

  changeReceiveNewsLetter(bool newValue) async {
    privacyModel.receivenewsletter = newValue;
    _updatePrivacy(privacyModel);
  }

  changeReceiveEmailWithPoints(bool newValue) {
    privacyModel.receiveemailspoints = newValue;
    _updatePrivacy(privacyModel);
  }

  changeReceiveMobileNotifications(bool newValue) {
    privacyModel.receivenotifications = newValue;
    _updatePrivacy(privacyModel);
  }

  _updatePrivacy(PrivacyModel privacyModel) async {
    var result = await locator<DataRepository>().setPrivacy(privacyModel);
    if (result is Right) {
      privacyModel = (result as Right).value as PrivacyModel;
      notifyListeners();
    } else {
      //show error
      SnackbarOverlay().show(
        addFrameCallback: true,
        onTap: () {
          SnackbarOverlay().closeCustomOverlay();
        },
        removeDuration: Duration(seconds: 5),
        text: 'Something went wrong, please try again later.',
        buttonText: 'OK',
        buttonTextColor: Colors.red,
      );
    }
  }
}
