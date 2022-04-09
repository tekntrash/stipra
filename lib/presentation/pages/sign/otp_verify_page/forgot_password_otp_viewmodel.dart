import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/errors/failure.dart';
import 'package:stipra/core/services/validator_service.dart';
import 'package:stipra/data/enums/reset_password_action_type.dart';
import 'package:stipra/data/enums/sms_action_type.dart';
import 'package:stipra/data/models/auto_validator_model.dart';
import 'package:stipra/domain/repositories/data_repository.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';

import '../../../../injection_container.dart';
import '../../../widgets/overlay/lock_overlay.dart';

class ForgotPasswordOtpViewModel extends BaseViewModel {
  String otp;
  String emailAddress;
  ForgotPasswordOtpViewModel({
    required this.otp,
    required this.emailAddress,
  });

  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController =
      StreamController<ErrorAnimationType>();
  ValueNotifier<int> waitBeforeResend = ValueNotifier(0);
  bool resendingOtp = false;
  bool hasError = false;
  String currentPin = "";
  final formKey = GlobalKey<FormState>();
  bool isCheckingPin = false;
  bool reachedLimit = false;
  AutoValidatorModel password = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );
  init() {}

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  Future<void> onConfirmed(
    BuildContext context,
  ) async {
    if (validatePinFieldsFilled()) {
      updateIsCheckingPinStatus(true);
      await Future.delayed(Duration(milliseconds: 150));
      updateIsCheckingPinStatus(false);
      if (isPinCorrect) {
        onPinConfirmed(context);
        return;
      }
    } else {
      if (isPinCorrect) {
        hasError = false;
        notifyListeners();
        return;
      }
    }
    shakePinFieldsForNotCorrect();
  }

  bool validatePinFieldsFilled() {
    return currentPin.length == 4 && formKey.currentState!.validate();
  }

  Future<void> onPinConfirmed(
    BuildContext context,
  ) async {
    hasError = false;
    notifyListeners();
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    await locator<DataRepository>().resetPassword(
      ResetPasswordActionType.resetpassword,
      emailAddress,
      password: password.textController.text,
    );
    LockOverlay().closeOverlay();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void resendOtp({bool force: false}) async {
    if ((resendingOtp || waitBeforeResend.value != 0) && !force) return;
    resendingOtp = true;
    notifyListeners();
    final result = await locator<DataRepository>().resetPassword(
      ResetPasswordActionType.sendemail,
      emailAddress,
    );
    log('message: $result');
    waitBeforeResend.value = 60;
    if (result is Left) {
      if ((result as Left).value is PhoneSmsExceededLimit) {
        reachedLimit = true;
      }
      SnackbarOverlay().show(
        text: '${(result as Left).value.errorMessage}',
        buttonText: 'OK',
        buttonTextColor: Colors.red,
        addFrameCallback: true,
        onTap: () {
          timer?.cancel();
          resendOtp(force: true);
          SnackbarOverlay().closeCustomOverlay();
        },
        removeDuration: Duration(seconds: 10),
        forceOverlay: true,
      );
    }
    countDownResend();
    resendingOtp = false;
    notifyListeners();
  }

  Timer? timer;
  countDownResend() {
    timer = Timer.periodic(Duration(seconds: 1), (_timer) {
      if (waitBeforeResend.value > 0) {
        waitBeforeResend.value--;
      } else {
        _timer.cancel();
        notifyListeners();
      }
    });
  }

  void shakePinFieldsForNotCorrect() {
    errorController!.add(ErrorAnimationType.shake);
    hasError = true;
    notifyListeners();
  }

  bool get isPinCorrect => currentPin == otp;

  void updateIsCheckingPinStatus(bool newStatus) {
    isCheckingPin = newStatus;
    notifyListeners();
  }
}
