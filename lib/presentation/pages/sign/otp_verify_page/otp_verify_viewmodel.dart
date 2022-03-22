import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/pages/home/home_page.dart';

import '../../../widgets/overlay/lock_overlay.dart';

class OtpVerifyViewModel extends BaseViewModel {
  OtpVerifyViewModel();

  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController =
      StreamController<ErrorAnimationType>();

  bool hasError = false;
  String currentPin = "";
  final formKey = GlobalKey<FormState>();
  bool isCheckingPin = false;

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
      LockOverlay().showClassicLoadingOverlay();
      //Response _response = await getUserRole();
      //var _isPinConfirmed = isPinCorrect(_response);
      var _isPinConfirmed = true;
      LockOverlay().closeOverlay();
      updateIsCheckingPinStatus(false);
      if (_isPinConfirmed) {
        //onPinConfirmed(context, response: _response);
        onPinConfirmed(context);
        return;
      }
    }
    shakePinFieldsForNotCorrect();
  }

  bool validatePinFieldsFilled() {
    return currentPin.length == 6 && formKey.currentState!.validate();
  }

  Future<void> onPinConfirmed(
    BuildContext context,
  ) async {
    hasError = false;
    notifyListeners();
    //final user = User.fromRawJson(response.data);
    //final ifRoleHaveError = user.role == null;
    //if (ifRoleHaveError) {
    //  SnackbarShow.showAndClear(context, 'An error occured, please try again.');
    //  return;
    //}
    //await HiveService().deleteAll();
    //await HiveService().addUser(user);
    var routePage;
    /*if (UserService().getLoggedUser().isCompany ||
        UserService().getLoggedUser().isEmployee) {
      routePage = StaticBar();
    } else {
      routePage = UserUpgradePage(
        customerId: customerId,
      );
    }*/
    routePage = HomePage();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => routePage),
      (route) => false,
    );
  }

  void shakePinFieldsForNotCorrect() {
    errorController!.add(ErrorAnimationType.shake);
    hasError = true;
    notifyListeners();
  }

  /*Future<Response> getUserRole() async {
    Response response = await DataProvider().request(
      VerifyPhoneNumberRequest(
        code: currentPin,
        customerId: customerId,
      ),
    );
    return response;
  }*/

  /*bool isPinCorrect(Response response) {
    print('Pin result: ${response.data}');
    var _isPinCorrect = response.data != 'fail';
    return _isPinCorrect;
  }*/

  void updateIsCheckingPinStatus(bool newStatus) {
    isCheckingPin = newStatus;
    notifyListeners();
  }
}
