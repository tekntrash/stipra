import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_package/requests/rest_api_request.dart';
import 'package:rest_api_package/rest_api_package.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/errors/failure.dart';
import 'package:stipra/core/services/location_service.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_routes.dart';
import 'package:stipra/data/models/user_model.dart';
import 'package:stipra/data/provider/data_provider.dart';
import 'package:stipra/domain/repositories/local_data_repository.dart';
import 'package:stipra/injection_container.dart';
import 'package:stipra/presentation/pages/sign/enter_phone_number_page/enter_phone_number_page.dart';
import 'package:stipra/presentation/pages/sign/otp_verify_page/otp_verify_page.dart';
import 'package:stipra/presentation/pages/tabbar_view_container.dart';
import 'package:stipra/presentation/widgets/overlay/snackbar_overlay.dart';
import 'package:stipra/presentation/widgets/snackbar_show.dart';

import '../../../../core/services/validator_service.dart';
import '../../../../data/models/auto_validator_model.dart';
import '../../../../data/models/validator_model.dart';
import '../../../../domain/repositories/data_repository.dart';
import '../../../widgets/overlay/lock_overlay.dart';
import '../forgot_password/forgot_password_page.dart';

class EnterPhoneNumberViewModel extends BaseViewModel {
  bool isSignIn;
  final Function()? onLogged, onVerified;
  EnterPhoneNumberViewModel({
    required this.isSignIn,
    this.onLogged,
    this.onVerified,
  });

  GlobalKey<FormState> formKey = GlobalKey();
  String? phoneNumber;
  String? dialCode;
  late ValidatorModel phonevalidator;
  AutoValidatorModel name = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text, maxLength: 32),
  );
  AutoValidatorModel email = AutoValidatorModel(
    validator: (text) => ValidatorService().email(text),
  );
  AutoValidatorModel password = AutoValidatorModel(
    validator: (text) =>
        ValidatorService().passwordUpperLowerNumber(text, minLength: 6),
  );

  init() {
    phonevalidator = ValidatorModel(validator: () async {
      final errorResult = ValidatorService().phoneNumberWith1To12(
        phonevalidator.textController.text,
      );

      phonevalidator.errorNotifier.value = errorResult;
    });
  }

  Future<void> verifyNumber(BuildContext context) async {
    phonevalidator.validate();
    if (formKey.currentState?.validate() == true) {
      if (isSignIn != true && phonevalidator.errorNotifier.value == null) {
        LockOverlay().showClassicLoadingOverlay();
        await sendBackendSignUpRequest(context);
        LockOverlay().closeOverlay();
        return;
      }
      LockOverlay().showClassicLoadingOverlay();
      await sendBackendSignInRequest(context);
      LockOverlay().closeOverlay();
    } else {
      //Error
    }
  }

  Future<void> sendBackendSignInRequest(BuildContext context) async {
    bool? isStayLoggedIn =
        locator<LocalDataRepository>().getUser().stayLoggedIn;
    final geo = await locator<LocationService>().getCurrentLocationAsString();
    final response = await locator<DataRepository>().login(
      email.textController.text,
      password.textController.text,
      isStayLoggedIn,
      geo,
    );
    if (response is Right) {
      await locator<LocalDataRepository>().cacheUser((response as Right).value);
      log('Cached user ${locator<LocalDataRepository>().getUser()}');
      if (onLogged != null) {
        onLogged!();
      } else {
        Navigator.of(context).pop();
      }
    } else {
      final failure = (response as Left).value;
      if (failure is PhoneVerifyFailure) {
        await locator<LocalDataRepository>().cacheUser(failure.userModel);
        SnackbarOverlay().show(
          text: '${failure.errorMessage}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          fullTap: true,
          onTap: () async {
            SnackbarOverlay().closeCustomOverlay();
            final logged = await AppNavigator.pushWithFadeIn<bool>(
              context: context,
              child: OtpVerifyPage(
                phoneNumber: phoneNumber,
                userModel: failure.userModel,
              ),
            );
            if (logged) onVerified?.call();
          },
          removeDuration: Duration(seconds: 5),
          forceOverlay: true,
        );
      } else {
        SnackbarOverlay().show(
          text: '${((response as Left).value as Failure).properties[0]}',
          buttonText: 'OK',
          buttonTextColor: Colors.red,
          addFrameCallback: true,
          onTap: () {
            SnackbarOverlay().closeCustomOverlay();
          },
          removeDuration: Duration(seconds: 3),
          forceOverlay: true,
        );
      }
    }
  }

  Future<void> sendBackendSignUpRequest(BuildContext context) async {
    bool? isStayLoggedIn =
        locator<LocalDataRepository>().getUser().stayLoggedIn;
    final isAccessGranted = await locator<LocationService>().isAccessGranted;
    if (!isAccessGranted) {
      locator<LocationService>().requestPermission(
        onRequestGranted: () {
          sendBackendSignUpRequest(context);
        },
      );
      return;
    }

    final geo = await locator<LocationService>().getCurrentLocation();
    final response = await locator<DataRepository>().register(
      email.textController.text,
      password.textController.text,
      name.textController.text,
      phoneNumber!,
      dialCode!,
      isStayLoggedIn,
      geo.latitude,
      geo.longitude,
    );
    if (response is Right) {
      await locator<LocalDataRepository>().cacheUser((response as Right).value);
      log('Cached user reg ${locator<LocalDataRepository>().getUser()}');
      if (onLogged != null) {
        AppNavigator.pushWithFadeIn<bool>(
          context: context,
          child: OtpVerifyPage(
            phoneNumber: phoneNumber,
            userModel: (response as Right).value,
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    } else {
      SnackbarOverlay().show(
        text: '${((response as Left).value as ServerFailure).errorMessage}',
        buttonText: 'OK',
        buttonTextColor: Colors.red,
        addFrameCallback: true,
        onTap: () {
          SnackbarOverlay().closeCustomOverlay();
        },
        removeDuration: Duration(seconds: 3),
        forceOverlay: true,
      );
    }
  }

  void onForgotPassword(BuildContext context) {
    AppNavigator.push(
      context: context,
      child: ForgotPasswordPage(),
    );
  }

  void changeSignPage() {
    isSignIn = !isSignIn;
    name.textController.clear();
    email.textController.clear();
    password.textController.clear();
    phonevalidator.textController.clear();
    phonevalidator.errorNotifier.value = null;
    notifyListeners();
  }
}