//* This is a custom component to use list of countries and show them in a component to select one.

import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/models/country_model.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/selector_config.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/test/test_helper.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/utils/util.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/widgets/countries_search_list_widget.dart';
// ignore: implementation_imports
import 'package:intl_phone_number_input/src/widgets/input_widget.dart';
import 'package:stipra/data/models/validator_model.dart';
import 'package:stipra/presentation/widgets/field_builder.dart';

/// [CountrySelectButton]
class CountrySelectButton extends StatelessWidget {
  final List<Country> countries;
  final Country? country;
  final SelectorConfig selectorConfig;
  final TextStyle? selectorTextStyle;
  final InputDecoration? searchBoxDecoration;
  final bool autoFocusSearchField;
  final String? locale;
  final bool isEnabled;
  final bool isScrollControlled;

  final ValueChanged<Country?> onCountryChanged;
  final ValidatorModel countryValidator;
  final String hintText;

  const CountrySelectButton({
    Key? key,
    required this.countries,
    required this.country,
    required this.selectorConfig,
    required this.selectorTextStyle,
    required this.searchBoxDecoration,
    required this.autoFocusSearchField,
    required this.locale,
    required this.onCountryChanged,
    required this.isEnabled,
    required this.isScrollControlled,
    required this.countryValidator,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return selectorConfig.selectorType == PhoneInputSelectorType.DROPDOWN
        ? countries.isNotEmpty && countries.length > 1
            ? DropdownButtonHideUnderline(
                child: DropdownButton<Country>(
                  key: Key(TestHelper.DropdownButtonKeyValue),
                  hint: Item(
                    country: country,
                    showFlag: selectorConfig.showFlags,
                    useEmoji: selectorConfig.useEmoji,
                    leadingPadding: selectorConfig.leadingPadding,
                    trailingSpace: selectorConfig.trailingSpace,
                    textStyle: selectorTextStyle,
                  ),
                  value: country,
                  items: mapCountryToDropdownItem(countries),
                  onChanged: isEnabled ? onCountryChanged : null,
                ),
              )
            : Item(
                country: country,
                showFlag: selectorConfig.showFlags,
                useEmoji: selectorConfig.useEmoji,
                leadingPadding: selectorConfig.leadingPadding,
                trailingSpace: selectorConfig.trailingSpace,
                textStyle: selectorTextStyle,
              )
        : MaterialButton(
            key: Key(TestHelper.DropdownButtonKeyValue),
            padding: EdgeInsets.zero,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            minWidth: 0,
            onPressed: countries.isNotEmpty && countries.length > 1 && isEnabled
                ? () async {
                    Country? selected;
                    if (selectorConfig.selectorType ==
                        PhoneInputSelectorType.BOTTOM_SHEET) {
                      selected = await showCountrySelectorBottomSheet(
                          context, countries);
                    } else {
                      selected =
                          await showCountrySelectorDialog(context, countries);
                    }

                    if (selected != null) {
                      onCountryChanged(selected);
                    }
                  }
                : null,
            child: IgnorePointer(
              ignoring: true,
              child: FieldBuilder(
                //enableBorderWithChild: true,
                controller: countryValidator.textController,
                text: '',
                hint: hintText,
                notifier: countryValidator.errorNotifier,
                validator: () {},
                showErrorOnlyIfTrue: true,
                textPadding: EdgeInsets.zero,
                keyboardType: TextInputType.number,
                fieldPadding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                disableDecoration: true,
                isEnabled: false,
                disableValidator: true,
                disabledTextColor: Colors.black,
                borderRadiusBottomLeft: Radius.zero,
                borderRadiusTopLeft: Radius.zero,
                leftWidget: Container(
                  child: Container(
                    height: double.infinity,
                    padding: EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: Item(
                      country: country,
                      showFlag: selectorConfig.showFlags,
                      useEmoji: selectorConfig.useEmoji,
                      leadingPadding: selectorConfig.leadingPadding,
                      trailingSpace: selectorConfig.trailingSpace,
                      textStyle: selectorTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  /// Converts the list [countries] to `DropdownMenuItem`
  List<DropdownMenuItem<Country>> mapCountryToDropdownItem(
      List<Country> countries) {
    return countries.map((country) {
      return DropdownMenuItem<Country>(
        value: country,
        child: Item(
          key: Key(TestHelper.countryItemKeyValue(country.alpha2Code)),
          country: country,
          showFlag: selectorConfig.showFlags,
          useEmoji: selectorConfig.useEmoji,
          textStyle: selectorTextStyle,
          withCountryNames: false,
        ),
      );
    }).toList();
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.DIALOG] is selected
  Future<Country?> showCountrySelectorDialog(
      BuildContext context, List<Country> countries) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: double.maxFinite,
          child: CountrySearchListWidget(
            countries,
            locale,
            searchBoxDecoration: searchBoxDecoration,
            showFlags: selectorConfig.showFlags,
            useEmoji: selectorConfig.useEmoji,
            autoFocus: autoFocusSearchField,
          ),
        ),
      ),
    );
  }

  /// shows a Dialog with list [countries] if the [PhoneInputSelectorType.BOTTOM_SHEET] is selected
  Future<Country?> showCountrySelectorBottomSheet(
      BuildContext context, List<Country> countries) {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Stack(children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
          ),
          DraggableScrollableSheet(
            builder: (BuildContext context, ScrollController controller) {
              return Container(
                decoration: ShapeDecoration(
                  color: Theme.of(context).canvasColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
                child: CountrySearchListWidget(
                  countries,
                  locale,
                  searchBoxDecoration: searchBoxDecoration,
                  scrollController: controller,
                  showFlags: selectorConfig.showFlags,
                  useEmoji: selectorConfig.useEmoji,
                  autoFocus: autoFocusSearchField,
                ),
              );
            },
          ),
        ]);
      },
    );
  }
}

/// [Item]
class Item extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final double? leadingPadding;
  final bool trailingSpace;

  const Item({
    Key? key,
    this.country,
    this.showFlag,
    this.useEmoji,
    this.textStyle,
    this.withCountryNames = false,
    this.leadingPadding = 12,
    this.trailingSpace = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialCode = (country?.dialCode ?? '');
    if (trailingSpace) {
      dialCode = dialCode.padRight(5, "   ");
    }
    return Container(
      child: Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(width: leadingPadding),
          _Flag(
            country: country,
            showFlag: showFlag,
            useEmoji: useEmoji,
          ),
        ],
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;

  const _Flag({Key? key, this.country, this.showFlag, this.useEmoji})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null && showFlag!
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headline5,
                  )
                : Image.asset(
                    country!.flagUri,
                    width: 32.0,
                    package: 'intl_phone_number_input',
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.shrink();
                    },
                  ),
          )
        : SizedBox.shrink();
  }
}
