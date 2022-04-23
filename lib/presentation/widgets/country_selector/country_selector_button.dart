import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/models/country_list.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/models/country_model.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/providers/country_provider.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/phone_number.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/selector_config.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/widget_view.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/widgets/selector_button.dart';
import 'package:stipra/data/models/validator_model.dart';
import 'package:stipra/presentation/widgets/classic_text.dart';
import 'package:stipra/shared/app_theme.dart';

import 'countries.dart';
import 'country_select_button.dart';

/// A [TextFormField] for [CountrySelectorButton].
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
class CountrySelectorButton extends StatefulWidget {
  final SelectorConfig selectorConfig;

  final ValueChanged<String> onCountryChanged;

  final String? initialValue;
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
  final ValidatorModel countryValidator;
  final EdgeInsets textfieldPadding;

  CountrySelectorButton(
      {Key? key,
      this.selectorConfig = const SelectorConfig(),
      required this.onCountryChanged,
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
      required this.countryValidator,
      this.textfieldPadding = const EdgeInsets.fromLTRB(12, 16, 12, 16),
      this.countries})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<CountrySelectorButton> {
  double selectorButtonBottomPadding = 0;

  Country? country;
  List<Country> countries = [];
  bool isNotValid = true;

  @override
  void initState() {
    super.initState();
    loadCountries();
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
  void didUpdateWidget(CountrySelectorButton oldWidget) {
    loadCountries(previouslySelectedCountry: country);
    if (oldWidget.initialValue != widget.initialValue) {
      if (country!.name != widget.initialValue) {
        loadCountries();
      }
    }
    super.didUpdateWidget(oldWidget);
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
          getInitialSelectedCountry(
            countries,
            widget.initialValue ?? '',
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

  Country getInitialSelectedCountry(
      List<Country> countries, String countryName) {
    return countries.firstWhere((country) => country.name == countryName,
        orElse: () => countries[0]);
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
    widget.onCountryChanged(country?.name ?? '');
    widget.countryValidator.textController.text = country?.name ?? '';
    //TODO country changed
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
    extends WidgetView<CountrySelectorButton, _InputWidgetState> {
  final _InputWidgetState state;

  _InputWidgetView({Key? key, required this.state})
      : super(key: key, state: state);

  @override
  Widget build(BuildContext context) {
    //final countryCode = state.country?.alpha2Code ?? '';
    //final dialCode = state.country?.dialCode ?? '';
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Container(
              padding: EdgeInsets.only(bottom: 5, left: 5),
              child: ClassicText(
                text: 'Country',
                style: AppTheme().smallParagraphMediumText.copyWith(
                      fontSize: AppTheme().paragraphSemiBoldText.fontSize,
                    ),
              ),
            ),
          ),
          CountrySelectButton(
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
            countryValidator: widget.countryValidator,
            hintText: 'Select a country',
          ),
        ],
      ),
    );
  }
}
