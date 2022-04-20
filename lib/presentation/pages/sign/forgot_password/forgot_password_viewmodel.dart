import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../core/services/validator_service.dart';
import '../../../../core/utils/router/app_navigator.dart';
import '../../../../data/enums/reset_password_action_type.dart';
import '../../../../data/enums/sms_action_type.dart';
import '../../../../data/models/auto_validator_model.dart';
import '../../../../data/models/validator_model.dart';
import '../../../../domain/repositories/data_repository.dart';
import '../../../../domain/repositories/local_data_repository.dart';
import '../enter_phone_number_page/enter_phone_number_page.dart';
import '../otp_verify_page/forgot_password_otp_page.dart';
import '../../../widgets/overlay/snackbar_overlay.dart';

import '../../../../injection_container.dart';

class ForgotPasswordViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  AutoValidatorModel email = AutoValidatorModel(
    validator: (text) => ValidatorService().email(text),
  );
  bool isSending = false;

  init() {}

  Future<void> sendForgotPassword(BuildContext context) async {
    if (isSending) return;
    if (formKey.currentState?.validate() == true) {
      final emailAddress = email.textController.text;
      isSending = true;
      notifyListeners();
      log('Form is valid and email is ${email.textController.text}');
      final result = await locator<DataRepository>().resetPassword(
        ResetPasswordActionType.sendemail,
        email.textController.text,
      );
      if (result is Right) {
        AppNavigator.push(
            context: context,
            child: ForgotPasswordOtpPage(
                otp: (result as Right).value, emailAddress: emailAddress));
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
