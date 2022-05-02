import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import '../../../core/errors/failure.dart';
import '../../../core/services/validator_service.dart';
import '../../../data/enums/change_email_action_type.dart';
import '../../../data/enums/reset_password_action_type.dart';
import '../../../data/enums/sms_action_type.dart';
import '../../../data/models/auto_validator_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../domain/repositories/local_data_repository.dart';
import '../home/home_page.dart';
import '../tabbar_view_container.dart';
import '../../widgets/overlay/lock_overlay.dart';
import '../../widgets/overlay/snackbar_overlay.dart';

import '../../../../injection_container.dart';

/// Change email OTP controller uses for sending backend requests and validate OTP
/// When user click on submit button, this controller will validate OTP
/// and send backend request to send email change request is confirmed

class ChangeEmailOtpViewModel extends BaseViewModel {
  String otp;
  String emailAddress;
  ChangeEmailOtpViewModel({
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

  /// When click confirm button, this method will validate parameters and send backend request
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

  /// Control If OTP code has been entered correctly
  bool validatePinFieldsFilled() {
    return currentPin.length == 4 && formKey.currentState!.validate();
  }

  /// If OTP Code is correct send backend request to change email
  /// And navigate to home page
  Future<void> onPinConfirmed(
    BuildContext context,
  ) async {
    hasError = false;
    notifyListeners();
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    final userModel = locator<LocalDataRepository>().getUser();
    final result = await locator<DataRepository>().changeEmail(
      ChangeEmailActionType.confirmchange,
      userModel.alogin ?? '',
      userModel.userid ?? '',
      emailAddress,
    );
    if (result is Right) {
      locator<LocalDataRepository>().getUser().alogin = emailAddress;
      await locator<LocalDataRepository>().getUser().save();
    }
    LockOverlay().closeOverlay();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  /// If OTP needed to be resend, this method will send backend request to resend OTP
  void resendOtp({bool force: false}) async {
    if ((resendingOtp || waitBeforeResend.value != 0) && !force) return;
    resendingOtp = true;
    notifyListeners();
    final userModel = locator<LocalDataRepository>().getUser();
    final result = await locator<DataRepository>().changeEmail(
      ChangeEmailActionType.change,
      userModel.alogin ?? '',
      userModel.userid ?? '',
      emailAddress,
    );
    log('message: $result');
    waitBeforeResend.value = 60;
    if (result is Left) {
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

  /// This method will count down for resend OTP to prevent multiple click
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

  /// If OTP not correct shake pin fields
  void shakePinFieldsForNotCorrect() {
    errorController!.add(ErrorAnimationType.shake);
    hasError = true;
    notifyListeners();
  }

  /// Control the pin is correct
  bool get isPinCorrect => currentPin == otp;

  /// Change ui with error status
  void updateIsCheckingPinStatus(bool newStatus) {
    isCheckingPin = newStatus;
    notifyListeners();
  }
}
