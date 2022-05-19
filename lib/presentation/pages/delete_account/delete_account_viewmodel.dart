import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/presentation/pages/good_bye/good_bye_page.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';

import '../../../../core/services/validator_service.dart';
import '../../../../data/enums/change_password_action_type.dart';
import '../../../../data/models/auto_validator_model.dart';
import '../../../../domain/repositories/data_repository.dart';
import '../../../../domain/repositories/local_data_repository.dart';
import '../../../../injection_container.dart';
import '../../../../shared/app_theme.dart';

class DeleteAccountViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  AutoValidatorModel oldPassword = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );
  bool isSending = false;

  init() {}

  Future<void> sendForgotPassword(BuildContext context) async {
    if (isSending) return;
    if (formKey.currentState?.validate() == true) {
      isSending = true;
      notifyListeners();
      log('Form is valid and oldPassword is ${oldPassword.textController.text}');
      final result = await locator<DataRepository>().deleteAccount(
        oldPassword.textController.text,
      );
      if (result is Right) {
        log('What should i do if correct?');
        logout();
        AppNavigator.pushAndRemoveUntil(context: context, child: GoodByePage());
      } else if (result is Left) {
        print('left?');
        SnackbarOverlay().show(
          text: '${(result as Left).value.errorMessage}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 4),
          forceOverlay: true,
        );
      }
      isSending = false;
    }
    notifyListeners();
  }

  logout() {
    locator<LocalDataRepository>().getUser().alogin = null;
    locator<LocalDataRepository>().getUser().userid = null;
    locator<LocalDataRepository>().getUser().name = null;
    locator<LocalDataRepository>().getUser().save();
  }
}
