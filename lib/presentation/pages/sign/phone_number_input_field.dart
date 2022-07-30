//* This is a custom component to use list of countries and show them in a component to select one.
//* It is providing a text field to write phone number and a button to show list of countries.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/models/country_list.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/models/country_model.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/providers/country_provider.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/phone_number.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/phone_number/phone_number_util.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/selector_config.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/util.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/widget_view.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/widgets/selector_button.dart';
import 'package:stipra/core/services/validator_service.dart';
import 'package:stipra/presentation/widgets/country_selector/countries.dart';
import 'package:stipra/shared/app_theme.dart';

import '../../../data/models/validator_model.dart';
import '../../widgets/field_builder.dart';

/// A [TextFormField] for [PhoneNumberInputField].
///
/// [initialValue] accepts a [PhoneNumber] this is used to set initial values
/// for phone the input field and the selector button
///
/// [selectorButtonOnErrorPadding] is a double which is used to align the selector
/// button with the input field when an error occurs
///
/// [locale] accepts a country locale which will be used to translation, if the
/// translation exist
///
/// [countries] accepts list of string on Country isoCode, if specified filters
/// available countries to match the [countries] specified.
class PhoneNumberInputField extends StatefulWidget {
  final SelectorConfig selectorConfig;

  final ValueChanged<PhoneNumber>? onInputChanged;
  final ValueChanged<bool>? onInputValidated;

  final VoidCallback? onSubmit;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final ValueChanged<PhoneNumber>? onSaved;

  final TextInputType keyboardType;
  final TextInputAction? keyboardAction;

  final PhoneNumber? initialValue;
  final String? hintText;
  final String? errorMessage;

  final double selectorButtonOnErrorPadding;

  /// Ignored if [setSelectorButtonAsPrefixIcon = true]
  final double spaceBetweenSelectorAndTextField;
  final int maxLength;

  final bool isEnabled;
  final bool formatInput;
  final bool autoFocus;
  final bool autoFocusSearch;
  final AutovalidateMode autoValidateMode;
  final bool ignoreBlank;
  final bool countrySelectorScrollControlled;

  final String? locale;

  final TextStyle? textStyle;
  final TextStyle? selectorTextStyle;
  final InputBorder? inputBorder;
  final InputDecoration? inputDecoration;
  final InputDecoration? searchBoxDecoration;
  final Color? cursorColor;
  final TextAlign textAlign;
  final TextAlignVertical textAlignVertical;
  final EdgeInsets scrollPadding;

  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;

  final List<String>? countries;
  final ValidatorModel phonevalidator;

  PhoneNumberInputField(
      {Key? key,
      this.selectorConfig = const SelectorConfig(),
      required this.onInputChanged,
      this.onInputValidated,
      this.onSubmit,
      this.onFieldSubmitted,
      this.validator,
      this.onSaved,
      this.keyboardAction,
      this.keyboardType = TextInputType.phone,
      this.initialValue,
      this.hintText = 'Phone number',
      this.errorMessage = 'Invalid phone number',
      this.selectorButtonOnErrorPadding = 24,
      this.spaceBetweenSelectorAndTextField = 12,
      this.maxLength = 15,
      this.isEnabled = true,
      this.formatInput = true,
      this.autoFocus = false,
      this.autoFocusSearch = false,
      this.autoValidateMode = AutovalidateMode.disabled,
      this.ignoreBlank = false,
      this.countrySelectorScrollControlled = true,
      this.locale,
      this.textStyle,
      this.selectorTextStyle,
      this.inputBorder,
      this.inputDecoration,
      this.searchBoxDecoration,
      this.textAlign = TextAlign.start,
      this.textAlignVertical = TextAlignVertical.center,
      this.scrollPadding = const EdgeInsets.all(20.0),
      this.focusNode,
      this.cursorColor,
      this.autofillHints,
      required this.phonevalidator,
      this.countries})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<PhoneNumberInputField> {
  double selectorButtonBottomPadding = 0;

  Country? country;
  List<Country> countries = [];
  bool isNotValid = true;

  @override
  void initState() {
    super.initState();
    loadCountries();
    initialiseWidget();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InputWidgetView(
      state: this,
    );
  }

  @override
  void didUpdateWidget(PhoneNumberInputField oldWidget) {
    loadCountries(previouslySelectedCountry: country);
    if (oldWidget.initialValue?.hash != widget.initialValue?.hash) {
      if (country!.alpha2Code != widget.initialValue?.isoCode) {
        loadCountries();
      }
      initialiseWidget();
    }
    super.didUpdateWidget(oldWidget);
  }

  /// [initialiseWidget] sets initial values of the widget
  void initialiseWidget() async {
    if (widget.initialValue != null) {
      if (widget.initialValue!.phoneNumber != null &&
          widget.initialValue!.phoneNumber!.isNotEmpty &&
          (await PhoneNumberUtil.isValidNumber(
              phoneNumber: widget.initialValue!.phoneNumber!,
              isoCode: widget.initialValue!.isoCode!))!) {
        String phoneNumber =
            await PhoneNumber.getParsableNumber(widget.initialValue!);

        widget.phonevalidator.textController.text = widget.formatInput
            ? phoneNumber
            : phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

        phoneNumberControllerListener();
      }
    }
  }

  List<Country> getCountriesData({required List<String>? countries}) {
    List jsonList = CountriesCustom.countryList;

    if (countries == null || countries.isEmpty) {
      return jsonList.map((country) => Country.fromJson(country)).toList();
    }
    List filteredList = jsonList.where((country) {
      return countries.contains(country[PropertyName]);
    }).toList();

    return filteredList.map((country) => Country.fromJson(country)).toList();
  }

  /// loads countries from [Countries.countryList] and selected Country
  void loadCountries({Country? previouslySelectedCountry}) {
    if (this.mounted) {
      List<Country> countries = getCountriesData(countries: widget.countries);

      Country country = previouslySelectedCountry ??
          Utils.getInitialSelectedCountry(
            countries,
            widget.initialValue?.isoCode ?? '',
          );

      // Remove potential duplicates
      countries = countries.toSet().toList();

      final CountryComparator? countryComparator =
          widget.selectorConfig.countryComparator;
      if (countryComparator != null) {
        countries.sort(countryComparator);
      }

      setState(() {
        this.countries = countries;
        this.country = country;
      });
    }
  }

  /// Listener that validates changes from the widget, returns a bool to
  /// the `ValueCallback` [widget.onInputValidated]
  void phoneNumberControllerListener() {
    if (this.mounted) {
      String parsedPhoneNumberString = widget.phonevalidator.textController.text
          .replaceAll(RegExp(r'[^\d+]'), '');

      getParsedPhoneNumber(parsedPhoneNumberString, this.country?.alpha2Code)
          .then((phoneNumber) {
        if (phoneNumber == null) {
          String phoneNumber =
              '${this.country?.dialCode}$parsedPhoneNumberString';

          if (widget.onInputChanged != null) {
            widget.onInputChanged!(PhoneNumber(
                phoneNumber: phoneNumber,
                isoCode: this.country?.alpha2Code,
                dialCode: this.country?.dialCode));
          }

          if (widget.onInputValidated != null) {
            widget.onInputValidated!(false);
          }
          this.isNotValid = true;
        } else {
          if (widget.onInputChanged != null) {
            widget.onInputChanged!(PhoneNumber(
                phoneNumber: phoneNumber,
                isoCode: this.country?.alpha2Code,
                dialCode: this.country?.dialCode));
          }

          if (widget.onInputValidated != null) {
            widget.onInputValidated!(true);
          }
          this.isNotValid = false;
        }
      });
    }
  }

  /// Returns a formatted String of [phoneNumber] with [isoCode], returns `null`
  /// if [phoneNumber] is not valid or if an [Exception] is caught.
  Future<String?> getParsedPhoneNumber(
      String phoneNumber, String? isoCode) async {
    if (phoneNumber.isNotEmpty && isoCode != null) {
      try {
        bool? isValidPhoneNumber = await PhoneNumberUtil.isValidNumber(
            phoneNumber: phoneNumber, isoCode: isoCode);

        if (isValidPhoneNumber!) {
          return await PhoneNumberUtil.normalizePhoneNumber(
              phoneNumber: phoneNumber, isoCode: isoCode);
        }
      } on Exception {
        return null;
      }
    }
    return null;
  }

  /// Creates or Select [InputDecoration]
  InputDecoration getInputDecoration(InputDecoration? decoration) {
    InputDecoration value = decoration ??
        InputDecoration(
          border: widget.inputBorder ?? UnderlineInputBorder(),
          hintText: widget.hintText,
        );

    if (widget.selectorConfig.setSelectorButtonAsPrefixIcon) {
      return value.copyWith(
          prefixIcon: SelectorButton(
        country: country,
        countries: countries,
        onCountryChanged: onCountryChanged,
        selectorConfig: widget.selectorConfig,
        selectorTextStyle: widget.selectorTextStyle,
        searchBoxDecoration: widget.searchBoxDecoration,
        locale: locale,
        isEnabled: widget.isEnabled,
        autoFocusSearchField: widget.autoFocusSearch,
        isScrollControlled: widget.countrySelectorScrollControlled,
      ));
    }

    return value;
  }

  /// Validate the phone number when a change occurs
  void onChanged(String value) {
    phoneNumberControllerListener();
  }

  /// Validate and returns a validation error when [FormState] validate is called.
  ///
  /// Also updates [selectorButtonBottomPadding]
  String? validator(String? value) {
    bool isValid =
        this.isNotValid && (value!.isNotEmpty || widget.ignoreBlank == false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (isValid && widget.errorMessage != null) {
        setState(() {
          this.selectorButtonBottomPadding =
              widget.selectorButtonOnErrorPadding;
        });
      } else {
        setState(() {
          this.selectorButtonBottomPadding = 0;
        });
      }
    });

    return isValid ? widget.errorMessage : null;
  }

  /// Changes Selector Button Country and Validate Change.
  void onCountryChanged(Country? country) {
    setState(() {
      this.country = country;
    });
    phoneNumberControllerListener();
  }

  void _phoneNumberSaved() {
    if (this.mounted) {
      String parsedPhoneNumberString = widget.phonevalidator.textController.text
          .replaceAll(RegExp(r'[^\d+]'), '');

      String phoneNumber =
          '${this.country?.dialCode ?? ''}' + parsedPhoneNumberString;

      widget.onSaved?.call(
        PhoneNumber(
            phoneNumber: phoneNumber,
            isoCode: this.country?.alpha2Code,
            dialCode: this.country?.dialCode),
      );
    }
  }

  /// Saved the phone number when form is saved
  void onSaved(String? value) {
    _phoneNumberSaved();
  }

  /// Corrects duplicate locale
  String? get locale {
    if (widget.locale == null) return null;

    if (widget.locale!.toLowerCase() == 'nb' ||
        widget.locale!.toLowerCase() == 'nn') {
      return 'no';
    }
    return widget.locale;
  }
}

class _InputWidgetView
    extends WidgetView<PhoneNumberInputField, _InputWidgetState> {
  final _InputWidgetState state;

  _InputWidgetView({Key? key, required this.state})
      : super(key: key, state: state);

  @override
  Widget build(BuildContext context) {
    //final countryCode = state.country?.alpha2Code ?? '';
    //final dialCode = state.country?.dialCode ?? '';

    return Container(
      child: FieldBuilder(
        controller: widget.phonevalidator.textController,
        text: 'Phone Number',
        titleStyle: AppTheme().smallParagraphMediumText.copyWith(
              fontSize: AppTheme().paragraphSemiBoldText.fontSize,
            ),
        hint: widget.hintText!,
        notifier: widget.phonevalidator.errorNotifier,
        validator: () {},
        showErrorOnlyIfTrue: true,
        onChanged: (text) async {
          state.onChanged(text!);
          if (widget.phonevalidator.textController.text.isEmpty) {
            widget.phonevalidator.errorNotifier.value =
                'text_field_error_message'.tr;
            return false;
          }
          final errorResult = ValidatorService().phoneNumberWith1To12(
            text,
          );

          widget.phonevalidator.errorNotifier.value = errorResult;

          return true;
        },
        disableAllBorder: true,
        keyboardType: TextInputType.number,
        fieldPadding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        isEnabled: true,
        //disableDecoration: true,
        disableValidator: true,
        disabledTextColor: Colors.grey[700],
        leftWidget: Container(
          height: double.infinity,
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: SelectorButton(
            country: state.country,
            countries: state.countries,
            onCountryChanged: state.onCountryChanged,
            selectorConfig: widget.selectorConfig,
            selectorTextStyle:
                widget.selectorTextStyle?.copyWith(color: Colors.black),
            searchBoxDecoration: widget.searchBoxDecoration,
            locale: state.locale,
            isEnabled: widget.isEnabled,
            autoFocusSearchField: widget.autoFocusSearch,
            isScrollControlled: widget.countrySelectorScrollControlled,
          ),
        ),
      ),
    );
  }
}
