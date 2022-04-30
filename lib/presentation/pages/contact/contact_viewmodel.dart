import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../core/services/validator_service.dart';
import '../../../data/models/auto_validator_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';
import '../../widgets/overlay/snackbar_overlay.dart';

class ContactViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();

  AutoValidatorModel name = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text),
  );
  AutoValidatorModel email = AutoValidatorModel(
    validator: (text) => ValidatorService().email(text),
  );
  AutoValidatorModel content = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text),
  );
  bool isSending = false;

  Future<void> sendMail(BuildContext context) async {
    if (isSending) return;
    isSending = true;
    notifyListeners();
    if (formKey.currentState?.validate() == true) {
      final result = await locator<DataRepository>().sendMail(
        name.textController.text,
        email.textController.text,
        content.textController.text,
      );
      if (result is Right) {
        if (!disposed) {
          Navigator.of(context).pop();
        }
        SnackbarOverlay().show(
          text: 'Your message has been sent',
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
        Color _errorColor = Colors.red;
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
      notifyListeners();
    }
  }
}