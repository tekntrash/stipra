import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/errors/failure.dart';
import 'package:stipra/core/services/validator_service.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/data/enums/change_email_action_type.dart';
import 'package:stipra/data/enums/change_password_action_type.dart';
import 'package:stipra/data/enums/reset_password_action_type.dart';
import 'package:stipra/data/enums/sms_action_type.dart';
import 'package:stipra/data/models/auto_validator_model.dart';
import 'package:stipra/data/models/validator_model.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/presentation/pages/change_email/change_email_otp_page.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';
import 'package:stipra/presentation/pages/sign/otp_verify_page/forgot_password_otp_page.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../../injection_container.dart';

class ChangeEmailViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  AutoValidatorModel oldEmail = AutoValidatorModel(
    validator: (text) => ValidatorService().email(text),
  );
  AutoValidatorModel newEmail = AutoValidatorModel(
    validator: (text) => ValidatorService().email(text),
  );
  bool isSending = false;

  init() {
    oldEmail.textController.text =
        locator<LocalDataRepository>().getUser().alogin ?? '';
  }

  Future<void> sendChangeEmail(BuildContext context) async {
    if (isSending) return;
    if (formKey.currentState?.validate() == true) {
      isSending = true;
      final userModel = locator<LocalDataRepository>().getUser();
      notifyListeners();
      log('Form is valid and oldEmail is ${oldEmail.textController.text}');
      final newEmailAddress = newEmail.textController.text;
      final result = await locator<DataRepository>().changeEmail(
        ChangeEmailActionType.change,
        userModel.alogin ?? '',
        userModel.userid ?? '',
        newEmailAddress,
      );
      if (result is Right) {
        log('Should not happen');
      } else if (result is Left) {
        print('left?');
        final asLeft = result as Left;
        Color _errorColor = Colors.red;
        if (asLeft.value is EmailVerifyFailure) {
          _errorColor = AppTheme().primaryColor;
          AppNavigator.push(
            context: context,
            child: ChangeEmailOtpPage(
              otp: (asLeft.value as EmailVerifyFailure).otp,
              emailAddress: newEmailAddress,
            ),
          );
        } else {
          //
        }
        SnackbarOverlay().show(
          text: '${(result as Left).value.errorMessage}',
          buttonText: 'OK',
          buttonTextColor: _errorColor,
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
