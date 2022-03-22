import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/core/utils/router/app_navigator.dart';
import 'package:stipra/core/utils/router/app_routes.dart';
import 'package:stipra/presentation/pages/sign/otp_verify_page/otp_verify_page.dart';

import '../../../../core/services/validator_service.dart';
import '../../../../data/models/auto_validator_model.dart';
import '../../../../data/models/validator_model.dart';
import '../../../widgets/overlay/lock_overlay.dart';

class EnterPhoneNumberViewModel extends BaseViewModel {
  bool? isSignIn;
  EnterPhoneNumberViewModel({
    this.isSignIn,
  });

  GlobalKey<FormState> formKey = GlobalKey();
  String? phoneNumber;
  late ValidatorModel phonevalidator;
  AutoValidatorModel taxId = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text, maxLength: 9),
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
    print(
        'Hey: ${formKey.currentState?.validate()} and ${phonevalidator.errorNotifier.value}');
    if (formKey.currentState?.validate() == true &&
        phonevalidator.errorNotifier.value == null) {
      //Continue
      print('Phone number: $phoneNumber');
      print('Tax number: ${taxId.textController.text}');
      LockOverlay().showClassicLoadingOverlay();
      //final response = await sendBackendSignRequest();
      await Future.delayed(Duration(seconds: 2));
      AppNavigator.push(
        context: context,
        child: OtpVerifyPage(phoneNumber: phoneNumber),
      );
      LockOverlay().closeOverlay();
      //checkBackendResponse(context, response);
    } else {
      //Error
    }
  }

  /*Future<Response> sendBackendSignRequest() async {
    phoneNumber = phoneNumber?.replaceFirst("+", '');
    final _signRequest = (isSignIn == true)
        ? SigninRequest(phoneNumber: phoneNumber)
        : SignupRequest(
            taxId: taxId.textController.text,
            phoneNumber: phoneNumber,
          );
    Response response = await DataProvider().request(_signRequest);
    return response;
  }*/

  /*void checkBackendResponse(BuildContext context, Response response) {
    if (response.data == null || response.data == 'fail') {
      SnackbarShow.showAndClear(context, 'The number is wrong.');
    } else if (response.data == 'exist') {
      SnackbarShow.showAndClear(
          context, 'This phone number is already registered.');
    } else if (response.data == 'number not exist') {
      SnackbarShow.showAndClear(
          context, 'This phone number is not registered.');
    } else {
      print('Response data: ${response.data}');
      String? customerId = response.data;

      if (customerId != null) {
        AppRouter().push(
          context: context,
          child: OtpVerifyPage(
            customerId: customerId,
            phoneNumber: phoneNumber,
          ),
        );
      } else {
        SnackbarShow.showAndClear(
            context, 'An error occured, please try again.');
      }
    }
  }*/
}
