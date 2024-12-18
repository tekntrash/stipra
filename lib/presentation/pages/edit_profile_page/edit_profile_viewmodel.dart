import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:stipra/presentation/widgets/country_selector/country_service.dart';
import '../../../data/models/validator_model.dart';

import '../../../../injection_container.dart';
import '../../../core/services/validator_service.dart';
import '../../../data/enums/change_profile_action_type.dart';
import '../../../data/models/auto_validator_model.dart';
import '../../../data/models/profile_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../widgets/overlay/lock_overlay.dart';
import '../../widgets/overlay/snackbar_overlay.dart';

/// Controller for edit profile page
/// This page provides to get profile information and edit them with backend service
/// It have variables for profile information and also for validation to check it in front
class EditProfileViewModel extends BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey();
  AutoValidatorModel address = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text),
  );
  AutoValidatorModel city = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text),
  );
  AutoValidatorModel zipcode = AutoValidatorModel(
    validator: (text) => ValidatorService().onlyRequired(text),
  );

  ValidatorModel gender = ValidatorModel();
  ValidatorModel countryValidator = ValidatorModel();
  String? countryShortName;
  ValidatorModel dateofbirth = ValidatorModel();
  bool isSending = false;

  /// Initialize the controller and show a loading component until the profile data is loaded
  /// When data loaded change parameters and notify listeners to update the view
  init() async {
    LockOverlay().showClassicLoadingOverlay(buildAfterRebuild: true);
    final result = await locator<DataRepository>()
        .changeProfile(ChangeProfileActionType.showprofile, null);
    if (result is Right) {
      final ProfileModel profile = (result as Right).value;
      address.textController.text = profile.address ?? '';

      countryShortName = profile.country ?? '';
      countryValidator.textController.text = CountryService()
              .findCountryWithAlpha2Code(profile.country ?? '')
              .name ??
          '';

      city.textController.text = profile.city ?? '';
      zipcode.textController.text = profile.zipcode ?? '';
      gender.textController.text = profile.gender == 'M'
          ? 'gender_male'.tr
          : profile.gender == 'F'
              ? 'gender_female'.tr
              : '';
      dateofbirth.textController.text = convertDateToString(
          convertStringToDateOneByOne(
              profile.dobday, profile.dobmonth, profile.dobyear));
      log('Gender: ${gender.textController.text}');
      notifyListeners();
    }
    LockOverlay().closeOverlay();
  }

  /// Control all parameters if they are ok send a request to backend
  /// and if success get profile again and show a loading component until profile loaded
  /// If fail show a snackbar with error message
  Future<void> sendChangeEmail(BuildContext context) async {
    if (isSending) return;
    countryValidator.validate();
    gender.validate();
    dateofbirth.validate();
    final isCountrySelected = countryValidator.errorNotifier.value == null;
    final isGenderSelected = countryValidator.errorNotifier.value == null;
    final isDateofbirthSelected = countryValidator.errorNotifier.value == null;
    if (formKey.currentState?.validate() == true &&
        isCountrySelected &&
        isGenderSelected &&
        isDateofbirthSelected) {
      isSending = true;
      notifyListeners();
      final dateofBirthDate =
          convertStringToDate(dateofbirth.textController.text)!;
      final result = await locator<DataRepository>().changeProfile(
        ChangeProfileActionType.changeprofile,
        ProfileModel(
          address: address.textController.text,
          country: countryShortName,
          city: city.textController.text,
          zipcode: zipcode.textController.text,
          dobday: '${dateofBirthDate.day}',
          dobmonth: '${dateofBirthDate.month}',
          dobyear: '${dateofBirthDate.year}',
          gender: gender.textController.text == 'gender_male'.tr ? 'M' : 'F',
        ),
      );
      if (result is Right) {
        init();
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
    }
    notifyListeners();
  }

  DateTime? convertStringToDate(String date) {
    if (date.isEmpty) return null;
    return DateTime.tryParse(date);
  }

  DateTime? convertStringToDateOneByOne(
      String? day, String? month, String? year) {
    if (day?.length == 1) day = '0$day';
    if (month?.length == 1) month = '0$month';
    String date = '$year-$month-$day';
    return DateTime.tryParse(date);
  }

  String convertDateToString(DateTime? dateTime) {
    String? day = dateTime?.day.toString();
    String? month = dateTime?.month.toString();
    if (day?.length == 1) day = '0$day';
    if (month?.length == 1) month = '0$month';
    return '${dateTime?.year}-$month-$day';
  }
}
