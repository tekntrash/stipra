import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/services/validator_service.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/enums/change_password_action_type.dart';
import 'package:stipra/data/enums/reset_password_action_type.dart';
import 'package:stipra/data/enums/sms_action_type.dart';
import 'package:stipra/data/models/auto_validator_model.dart';
import 'package:stipra/data/models/validator_model.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';
import 'package:stipra/presentation/pages/sign/otp_verify_page/forgot_password_otp_page.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../../injection_container.dart';

class ChangePasswordViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  AutoValidatorModel oldPassword = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );
  AutoValidatorModel newPassword = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );
  bool isSending = false;

  init() {}

  Future<void> sendForgotPassword(BuildContext context) async {
    if (isSending) return;
    if (formKey.currentState?.validate() == true) {
      isSending = true;
      final userModel = locator<LocalDataRepository>().getUser();
      notifyListeners();
      log('Form is valid and oldPassword is ${oldPassword.textController.text}');
      final result = await locator<DataRepository>().changePassword(
        ChangePasswordActionType.changepassword,
        userModel.alogin ?? '',
        userModel.userid ?? '',
        newpassword: newPassword.textController.text,
      );
      if (result is Right) {
        log('What should i do if correct?');
        Navigator.of(context).pop();
        SnackbarOverlay().show(
          text: 'Your password changed!',
          buttonText: 'OK',
          buttonTextColor: AppTheme().primaryColor,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 4),
          forceOverlay: true,
        );
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
}
